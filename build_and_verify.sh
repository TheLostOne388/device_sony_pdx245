#!/bin/bash
# Sony pdx245 Standard AOSP Build Script
# Uses LineageOS-proven approach - no custom scripts or workarounds needed

set -e

echo "=== SONY PDX245 STANDARD BUILD (LINEAGEOS APPROACH) ==="
echo "Using proven LineageOS configuration - no custom scripts needed!"
echo

# Check if we're in the right directory
if [ ! -f "build/envsetup.sh" ]; then
    echo "Error: Not in Android source root directory"
    exit 1
fi

# Setup build environment
echo "Setting up build environment..."
source build/envsetup.sh
lunch lineage_pdx245-ap4a-userdebug

# Clean build (recommended for consistency)
echo "Performing clean build..."
make clean

# Build the ROM using standard AOSP process
echo "Building ROM (this will take a while)..."
make -j$(nproc)

echo
echo "=== BUILD COMPLETE ==="
echo "Using standard AOSP AVB configuration - no post-processing needed!"
echo
echo "Key benefits of this approach:"
echo "✅ No custom scripts to maintain"
echo "✅ Standards-compliant AVB implementation"
echo "✅ Proven to work on LineageOS pdx234"
echo "✅ Strategic partition verification assignment"
echo
echo "Flash command sequence:"
echo "  fastboot flash vbmeta out/target/product/pdx245/vbmeta.img"
echo "  fastboot flash boot out/target/product/pdx245/boot.img"
echo "  fastboot flash init_boot out/target/product/pdx245/init_boot.img"
echo "  fastboot flash dtbo out/target/product/pdx245/dtbo.img"
echo "  fastboot flash vendor_boot out/target/product/pdx245/vendor_boot.img"
echo "  fastboot flash recovery out/target/product/pdx245/recovery.img"
echo "  fastboot flash vbmeta_system out/target/product/pdx245/vbmeta_system.img"
echo "  fastboot flash system out/target/product/pdx245/system.img"
echo "  fastboot flash product out/target/product/pdx245/product.img"
echo "  fastboot flash system_ext out/target/product/pdx245/system_ext.img"
echo "  fastboot flash odm out/target/product/pdx245/odm.img"
echo "  fastboot flash vendor out/target/product/pdx245/vendor.img"
echo "  fastboot flash system_dlkm out/target/product/pdx245/system_dlkm.img"
echo "  fastboot flash vendor_dlkm out/target/product/pdx245/vendor_dlkm.img"
echo "  fastboot reboot"
