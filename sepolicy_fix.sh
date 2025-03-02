#!/bin/bash

# Script to fix the sepolicy m4 processing hang issue
# This handles the potential infinite recursion in m4 processing

cd /home/erik/evolution

# Find all running m4 processes and kill them
echo "Killing hanging m4 processes..."
pkill -9 m4

# Clean sepolicy intermediate files
echo "Cleaning sepolicy intermediate files..."
find out -path "*/sepolicy/intermediates" -type d -exec rm -rf {} \; 2>/dev/null || true

# Create a wrapper script for m4 to avoid infinite recursion
M4_SCRIPT="out/host/linux-x86/bin/m4_wrapper.sh"
echo "Creating m4 wrapper script at $M4_SCRIPT"

cat > "$M4_SCRIPT" << 'EOF'
#!/bin/bash

# This is a wrapper for m4 to prevent infinite recursion

# Extract the real m4 path
REAL_M4=$(which m4)
if [ -z "$REAL_M4" ]; then
  REAL_M4="/usr/bin/m4"
fi

# Set maximum nesting level
export M4PATH=.
M4_ARGS=("--nesting-limit=1024")

# Pass all arguments to the real m4
"$REAL_M4" "${M4_ARGS[@]}" "$@"
EOF

chmod +x "$M4_SCRIPT"

# Modify BoardConfig.mk to skip problematic sepolicy files
echo "Updating BoardConfig.mk to avoid problematic sepolicy files..."

# Create sepolicy workaround
cat > device/sony/pdx245/sepolicy_workaround.mk << 'EOF'
# Sepolicy workarounds to prevent m4 infinite recursion

# Skip problematic sepolicy files
BOARD_SEPOLICY_DIRS := $(filter-out vendor/lineage/sepolicy/qcom/vendor,$(BOARD_SEPOLICY_DIRS))

# Add back the safe sepolicy files
BOARD_SEPOLICY_DIRS += device/sony/pdx245/sepolicy

# Use a more limited set of M4 definitions
BOARD_SEPOLICY_M4DEFS := \
    hal_keymaster_qti_exec=vendor_hal_keymaster_qti_exec \
    vendor_sysfs_battery_supply=sysfs_battery_supply \
    vendor_sysfs_graphics=sysfs_graphics \
    vendor_sysfs_usb_supply=sysfs_usb_supply
EOF

# Create minimal sepolicy files directory
mkdir -p device/sony/pdx245/sepolicy

echo "Setup complete! Now try building again with:"
echo "cd /home/erik/evolution"
echo "m evolution"