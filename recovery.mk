#
# Recovery Configuration for Sony PDX245
# Separated from BoardConfig.mk for better organization
#

# ============ TRADITIONAL RECOVERY APPROACH ============
# Create separate recovery.img file (traditional Android approach)
# Note: This disables GKI vendor_boot recovery integration

# Recovery resources in dedicated recovery.img
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600

# Recovery configuration
RECOVERY_VARIANT := lineage

# GKI Dynamic Partition Support
BOARD_RECOVERY_USE_SUPER_PARTITION := true
BOARD_BUILD_RECOVERY_DYNAMIC_PARTITION := true

# GKI Recovery Device Modules
TARGET_RECOVERY_DEVICE_MODULES += \
    dmctl \
    lpdump \
    lpmake \
    lpunpack \
    awk

PRODUCT_REPACK_RECOVERY_IMAGES := false # Override from common to prevent conflicts

# Ensure dmctl is built from source and included in recovery
# TARGET_RECOVERY_DEVICE_MODULES += dmctl  # Moved to device.mk

# Recovery filesystem and branding
BOARD_RECOVERY_FILESYSTEM_TYPE := f2fs
RECOVERY_VARIANT := lineage

# Recovery partition configuration
BOARD_ROOT_EXTRA_FOLDERS += metadata/ota

# Recovery architecture automatically inherits from device settings
# No custom architecture flags needed - build system handles this

# Recovery image configuration - GKI uses vendor_boot, no separate recovery.img needed
# TARGET_NO_RECOVERY := false  # Commented out for GKI - recovery integrated into vendor_boot

# Recovery image settings - not applicable for GKI vendor_boot recovery
# BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
# TARGET_RECOVERY_DISABLE_MKBOOTIMG_VERSION_ARGS := true
# BOARD_RECOVERY_MKBOOTIMG_ARGS :=

# Recovery post-install commands
TARGET_RECOVERY_POST_INSTALL_CMD := \
    ln -sf /system/bin/init $(TARGET_RECOVERY_ROOT_OUT)/init

# Recovery utilities
TARGET_RECOVERY_UTILS_PROGS += fsck.f2fs f2fsresize mkfs.f2fs

# ============ RECOVERY CONFIGURATION ============
# Ensure the full-featured dmctl is included in recovery for logical partitions
# TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# Recovery image handling - GKI uses vendor_boot integration
# BOARD_USES_RECOVERY_AS_BOOT := true
# TARGET_NO_RECOVERY := false  # Commented out for GKI - recovery integrated into vendor_boot
# BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600

# Let Android build system handle recovery files automatically
# Remove custom recovery file references

# Let Android build system handle recovery automatically
# Remove manual recovery configurations to allow natural build process

# Exclude kernel from recovery image (ramdisk-only like stock)
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

# Let recovery size inherit from common config to match stock
# BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600

# BOARD_RECOVERY_USE_FULL_PARTITION := true
TARGET_RECOVERY_DISABLE_MKBOOTIMG_VERSION_ARGS := true

# Recovery mkbootimg arguments
BOARD_RECOVERY_MKBOOTIMG_ARGS :=

# TEMPORARY TEST: Override the common config to disable kernel in recovery (like stock)
# BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

# Recovery post-install commands
TARGET_RECOVERY_POST_INSTALL_CMD := \
    ln -sf /system/bin/init $(TARGET_RECOVERY_ROOT_OUT)/init

# Recovery utilities
TARGET_RECOVERY_UTILS_PROGS += fsck.f2fs f2fsresize mkfs.f2fs

# PDX234 doesn't use manual dynamic partition handling in recovery
# Android handles logical partitions automatically through fstab

# GKI Recovery Device Modules (includes device mapper tools)
TARGET_RECOVERY_DEVICE_MODULES += \
    e2fsck \
    mke2fs \
    tune2fs \
    resize2fs \
    blkid \
    fsck.f2fs \
    make_f2fs \
    sload_f2fs

# GKI: Recovery gets tools via vendor_boot integration

# Recovery SELinux policies
BOARD_RECOVERY_SEPOLICY_DIRS += device/sony/pdx245/sepolicy/recovery
