#!/usr/bin/env python3

"""
Fix vbmeta.img vendor_boot hash descriptor exclusion for Sony pdx245
This prevents "device is corrupt" errors by ensuring vbmeta doesn't include vendor_boot descriptors
when using stock footerless vendor_boot.img
"""

import os
import sys
import subprocess
import tempfile

def patch_vbmeta_build():
    """Patch the vbmeta build to exclude vendor_boot descriptors"""
    
    # Check if we're in Android build environment
    if not os.path.exists('build/make/core/Makefile'):
        print("Error: Not in Android build root directory")
        return False
    
    # Find the vbmeta build rule in Makefile
    makefile_path = 'build/make/core/Makefile'
    
    # Read current Makefile
    with open(makefile_path, 'r') as f:
        content = f.read()
    
    # Look for vbmeta image creation rules
    if 'BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS' in content:
        print("✅ Found vbmeta build rules in Makefile")
        
        # Check if our patch is already applied
        if 'pdx245_vendor_boot_exclusion' in content:
            print("✅ Vendor boot exclusion patch already applied")
            return True
        
        # Add exclusion for vendor_boot in vbmeta generation
        patch_marker = "# pdx245_vendor_boot_exclusion - exclude vendor_boot from vbmeta descriptors"
        
        # Find the vbmeta creation section and add our exclusion
        vbmeta_section = content.find('$(AVBTOOL) make_vbmeta_image')
        if vbmeta_section != -1:
            # Insert our patch before the avbtool command
            patch_content = f"""
{patch_marker}
ifeq ($(TARGET_DEVICE),pdx245)
# Exclude vendor_boot from vbmeta descriptors for Sony pdx245 (uses stock footerless vendor_boot)
INTERNAL_AVB_PARTITIONS_IN_CHAINED_VBMETA_IMAGES := $(filter-out vendor_boot,$(INTERNAL_AVB_PARTITIONS_IN_CHAINED_VBMETA_IMAGES))
endif

"""
            content = content[:vbmeta_section] + patch_content + content[vbmeta_section:]
            
            # Write patched Makefile
            with open(makefile_path, 'w') as f:
                f.write(content)
            
            print("✅ Applied vendor_boot exclusion patch to Makefile")
            return True
        else:
            print("❌ Could not find vbmeta creation section in Makefile")
            return False
    else:
        print("❌ Could not find vbmeta build rules in Makefile")
        return False

def rebuild_vbmeta():
    """Rebuild only vbmeta images after applying patches"""
    print("🔄 Rebuilding vbmeta images...")
    
    # Clean vbmeta targets
    subprocess.run(['make', 'clean-vbmeta'], cwd=os.getcwd())
    
    # Rebuild vbmeta
    result = subprocess.run(['make', 'vbmetaimage', '-j8'], cwd=os.getcwd())
    
    if result.returncode == 0:
        print("✅ VBMeta rebuild successful")
        return True
    else:
        print("❌ VBMeta rebuild failed")
        return False

def verify_vbmeta():
    """Verify the fixed vbmeta image"""
    vbmeta_path = 'out/target/product/pdx245/vbmeta.img'
    
    if not os.path.exists(vbmeta_path):
        print("❌ VBMeta image not found after rebuild")
        return False
    
    # Check vbmeta contents
    try:
        result = subprocess.run([
            'python3', 'external/avb/avbtool.py', 'info_image', 
            '--image', vbmeta_path
        ], capture_output=True, text=True)
        
        if result.returncode == 0:
            info = result.stdout
            print("📋 VBMeta verification:")
            
            # Check for vendor_boot descriptors
            if 'vendor_boot' in info:
                if 'Hash descriptor' in info and 'vendor_boot' in info:
                    print("❌ vendor_boot hash descriptor still present in vbmeta")
                    return False
                elif 'Chain Partition descriptor' in info and 'vendor_boot' in info:
                    print("❌ vendor_boot chain descriptor still present in vbmeta")  
                    return False
                else:
                    print("✅ vendor_boot references removed from vbmeta")
            else:
                print("✅ No vendor_boot descriptors found in vbmeta")
            
            # Check rollback locations
            lines = info.split('\n')
            for line in lines:
                if 'Rollback Index Location:' in line and 'Partition Name:' in lines[lines.index(line)-1]:
                    partition = lines[lines.index(line)-1].split(':')[1].strip()
                    location = line.split(':')[1].strip()
                    print(f"   {partition}: Location {location}")
            
            return True
        else:
            print(f"❌ Failed to analyze vbmeta: {result.stderr}")
            return False
            
    except Exception as e:
        print(f"❌ Error verifying vbmeta: {e}")
        return False

def main():
    print("🔧 Sony Xperia 1 V VBMeta Device Corruption Fix")
    print("==============================================")
    
    if not patch_vbmeta_build():
        print("❌ Failed to apply vbmeta patches")
        return 1
    
    if not rebuild_vbmeta():
        print("❌ Failed to rebuild vbmeta")
        return 1
    
    if not verify_vbmeta():
        print("❌ VBMeta verification failed")
        return 1
    
    print("")
    print("✅ VBMeta device corruption fix completed successfully!")
    print("")
    print("📋 Next steps:")
    print("   1. Flash the fixed vbmeta: fastboot flash vbmeta out/target/product/pdx245/vbmeta.img")
    print("   2. Flash recovery: fastboot flash recovery out/target/product/pdx245/recovery.img")
    print("   3. Test boot: fastboot reboot recovery")
    
    return 0

if __name__ == '__main__':
    sys.exit(main()) 