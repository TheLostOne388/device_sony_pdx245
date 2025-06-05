CUSTOM_BUILD_VARS += PDX245_SECURITY_PATCH_OVERRIDE
PDX245_SECURITY_PATCH_OVERRIDE_VARS := \
    PLATFORM_SECURITY_PATCH \
    PLATFORM_VERSION_LAST_STABLE
PDX245_SECURITY_PATCH_OVERRIDE_FILE := $(DEVICE_PATH)/custom_build_vars.mk

# Override LineageOS flag to allow our GKI prebuilt logic to work
TARGET_FORCE_PREBUILT_KERNEL := true
# Explicitly point to the GKI prebuilt kernel image for any logic that uses TARGET_PREBUILT_KERNEL
TARGET_PREBUILT_KERNEL := $(TOP)/kernel/prebuilts/6.6/arm64/kernel-6.6-gz

# Include BoardConfigSoong.mk early, before SOONG_CONFIG_NAMESPACES is modified by this file.
include vendor/lineage/config/BoardConfigSoong.mk

# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# In device/sony/pdx245/BoardConfig.mk
TARGET_USES_QCOM_MM_AUDIO := false
BOARD_SUPPORTS_OPENSOURCE_STHAL := false
# Add a custom comment or flag if possible to exclude audio PAL builds
# BOARD_EXCLUDE_QCOM_AUDIO_PAL := true

# TARGET_BOARD_PLATFORM already defined in BoardConfigCommon.mk
TARGET_COMPILE_WITH_MSM_KERNEL := true

DEVICE_PATH := device/sony/pdx245
-include device/sony/sm8650-common/BoardConfigCommon.mk
PRODUCT_REPACK_RECOVERY_IMAGES := false # Override from common to prevent conflicts

TARGET_VENDOR_PLATFORM_SECURITY_PATCH := 2025-04-01

# Enable Treble Support
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_VNDK_VERSION := current

# SELinux Permissive for diagnostics
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

# Move vendor_dlkm out of vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USES_VENDOR_DLKMIMAGE := true
BOARD_VENDOR_DLKMIMAGE_PARTITION_SIZE := 157286400  # 150MB instead of 100MB

# Recovery partition configuration
# TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_NO_RECOVERY := false # Ensure a recovery partition is built
# BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600 # Match stock 100MiB
# NOTE: This is already defined in sm8650-common/BoardConfigCommon.mk (104857600)
# Uncommenting this would override the common value - only do if device-specific size needed
# TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab

# Exclude kernel from recovery image (ramdisk-only like stock)
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

# Use custom bootimg build to avoid automatic version arguments
# BOARD_CUSTOM_BOOTIMG_MK := $(DEVICE_PATH)/recovery/recovery_bootimg.mk
# BOARD_CUSTOM_BOOTIMG_MK += $(DEVICE_PATH)/recovery/boot_bootimg.mk
# BOARD_CUSTOM_BOOTIMG_MK += $(DEVICE_PATH)/recovery/init_boot_bootimg.mk # Removed for prebuilt init_boot

# Completely disable automatic OS version injection for all boot images
TARGET_RECOVERY_DISABLE_MKBOOTIMG_VERSION_ARGS := true
TARGET_BOOT_DISABLE_MKBOOTIMG_VERSION_ARGS := true
TARGET_INIT_BOOT_DISABLE_MKBOOTIMG_VERSION_ARGS := true

# Clear problematic args that interfere with custom makefiles
BOARD_RECOVERY_MKBOOTIMG_ARGS := # Revert to empty
BOARD_BOOTIMAGE_MKBOOTIMG_ARGS :=

# Display
TARGET_SCREEN_DENSITY := 396

# Props
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

BOARD_USES_VENDOR_DLKM := true

# Define base kernel path for crDroid GKI prebuilt
_KERNEL_PREBUILT_DIR_TEMP := $(TOP)/kernel/prebuilts/6.6/arm64
KERNEL_PREBUILT_DIR := $(strip $(_KERNEL_PREBUILT_DIR_TEMP))

# Kernel Configuration
TARGET_NO_KERNEL := false # As per LKG
# TEMPORARY TEST: Override the common config to disable kernel in recovery (like stock)
TARGET_NO_KERNEL_OVERRIDE := false
# Use GKI base config for Kernel 6.6
TARGET_KERNEL_CONFIG := $(TOP)/kernel/configs/v/android-6.6/android-base.config
BOARD_KERNEL_IMAGE_NAME := kernel-6.6-gz # Explicitly set the prebuilt image name
# Point to the crDroid prebuilt kernel image
INSTALLED_KERNEL_TARGET := $(KERNEL_PREBUILT_DIR)/$(BOARD_KERNEL_IMAGE_NAME)
# BOARD_KERNEL_CONFIG_FILE := $(KERNEL_PREBUILT_DIR)/kernel.config # This would be for a config file in the prebuilt dir

# Offsets for boot.img contents
# BOARD_KERNEL_BASE is 0x00000000 from sm8650-common/BoardConfigCommon.mk
# BOARD_KERNEL_PAGESIZE is 4096 from sm8650-common/BoardConfigCommon.mk
# BOARD_BOOT_HEADER_VERSION is 4 from sm8650-common/BoardConfigCommon.mk (ensure it's set or inherited)
BOARD_KERNEL_OFFSET      := 0x00008000
BOARD_RAMDISK_OFFSET     := 0x01000000 # Ramdisk itself is empty in boot.img (it's in init_boot.img for header v4)
                                      # This offset is primarily for mkbootimg's internal layout calculations.
BOARD_DTB_OFFSET         := 0x01F00000 # Offset for the DTB when using --dtb with mkbootimg.

# Add these to BOARD_MKBOOTIMG_ARGS.
# sm8650-common/BoardConfigCommon.mk already adds --header_version to BOARD_MKBOOTIMG_ARGS.
# Your pdx245/BoardConfig.mk clears BOARD_BOOTIMAGE_MKBOOTIMG_ARGS (more specific var for boot.img),
# so we define it fully here.
BOARD_BOOTIMAGE_MKBOOTIMG_ARGS := \
    --header_version $(BOARD_BOOT_HEADER_VERSION) \
    --kernel_offset $(BOARD_KERNEL_OFFSET) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --dtb $(BOARD_PREBUILT_DTBIMAGE) \
    --dtb_offset $(BOARD_DTB_OFFSET)

# The kernel version string might be derived differently or automatically by the build system
# for these newer GKIs if prebuilt-info.txt doesn't contain the full string.
# We'll keep the old one for now and see if the build complains or if it's correctly inferred.
# If errors, we may need to find the exact version string for the 6.6 GKI or adjust this.
_BOARD_KERNEL_VERSION_TEMP := 6.6.57-android15-8-g8b48c9979699-ab12748506-4k # Placeholder - adjust if exact version is found/needed
BOARD_KERNEL_VERSION := $(strip $(_BOARD_KERNEL_VERSION_TEMP))

# Kernel Headers
TARGET_KERNEL_HEADER_ARCH := arm64
# The following paths will now point to $(TOP)/kernel/prebuilts/6.6/arm64/
# The build system might use kheaders.ko if available, or expect a kernel-headers dir.
# If build fails related to headers, these paths or TARGET_USE_PREBUILT_KERNEL_HEADERS may need adjustment.
TARGET_BOARD_KERNEL_HEADERS := $(KERNEL_PREBUILT_DIR)/kernel-headers # Path might need to change if only kheaders.ko exists
TARGET_NO_KERNEL_HEADERS := true
TARGET_USE_PREBUILT_KERNEL_HEADERS := true
BOARD_VENDOR_KERNEL_HEADERS := $(KERNEL_PREBUILT_DIR)/kernel-headers # Path might need to change
BOARD_PREBUILT_KERNEL_HEADERS := $(KERNEL_PREBUILT_DIR)/kernel-headers # Path might need to change
TARGET_SPECIFIC_HEADER_PATH += $(KERNEL_PREBUILT_DIR)/kernel-headers # Path might need to change

# Define the header library that other modules can depend on
BOARD_HEADER_LIBRARIES += \
    generated_kernel_headers \
    qti_kernel_headers

# Make sure Soong can find the headers
SOONG_CONFIG_NAMESPACES += kernel_headers
SOONG_CONFIG_kernel_headers += kernel_headers_path
SOONG_CONFIG_kernel_headers_kernel_headers_path := $(KERNEL_PREBUILT_DIR)/kernel-headers # Path might need to change

# DTB/DTBO Configuration - Keep using Sony prebuilts for these
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE := $(TOP)/kernel/sony/pdx245/prebuilts/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(TOP)/kernel/sony/pdx245/prebuilts/dtbo.img # This is the raw stock content
BOARD_KERNEL_SEPARATED_DTBO := true

# DLKM Images - These might need to come from crDroid GKI prebuilts too, or be rebuilt.
# For now, keeping Sony ones. If errors, investigate kernel/prebuilts/6.1/arm64/system_dlkm_staging/
# BOARD_PREBUILT_SYSTEM_DLKM := $(TOP)/kernel/sony/pdx245/prebuilts/system_dlkm.img # Commented out to allow build from GKI modules
BOARD_PREBUILT_VENDOR_DLKM := $(TOP)/kernel/sony/pdx245/prebuilts/vendor_dlkm.img

# Vendor Boot modules
# BOARD_VENDOR_KERNEL_MODULES_LOAD := $(TOP)/vendor/sony/pdx245/proprietary/vendor/lib/modules/modules.load

# Use prebuilt stock vendor_boot.img
TARGET_PREBUILT_VENDOR_BOOTIMAGE := $(DEVICE_PATH)/prebuilt_vendor_boot/vendor_boot.img # Ensure stock vendor_boot_216.img is here
# NOTE: This ensures vendor_boot uses stock image with hash descriptor in vbmeta
# Ensure vbmeta.img hashes the content of the prebuilt vendor_boot.img, do not add a new footer to vendor_boot.img itself.
BOARD_AVB_VENDOR_BOOT_ADD_HASH_FOOTER_ARGS :=

TARGET_SEPOLICY_DIR := sm8650

# VINTF Overrides & Settings
override DEVICE_MATRIX_FILE := \
    $(DEVICE_PATH)/vintf/device_compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    $(DEVICE_PATH)/vintf/lineage_compat_matrix.xml \
    $(DEVICE_PATH)/vintf/device_framework_compatibility_matrix.xml \
    $(DEVICE_PATH)/vintf/device_framework_compatibility_matrix2.xml
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/vintf/manifest.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := $(DEVICE_PATH)/vintf/framework_manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/vintf/compatibility_matrix.device.xml
PRODUCT_ENFORCE_VINTF_MANIFEST := true
BUILD_BROKEN_VINTF_LEVEL_MISMATCH := true

# Sepolicy
BOARD_SHIPPING_API_LEVEL := 34
BOARD_SHIPPING_FCM_VERSION := 8
BOARD_SYSTEMSDK_VERSIONS := 34 35
BOARD_SEPOLICY_VERS := 34.0
BOARD_SEPOLICY_VERS_API := 34
PLATFORM_SEPOLICY_COMPAT_VERSIONS := 29.0 30.0 31.0 32.0 33.0 34.0
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true
BUILD_BROKEN_VINTF_VALIDATES_SEPOLICY_VERSION := true
BOARD_SEPOLICY_M4DEFS += module_dataoem=true wifi_qcom_regdom=true
include device/sony/pdx245/sepolicy_fixed/sepolicy.mk
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/lineage/sepolicy/qcom/dynamic \
    vendor/sony/sm8650-common/sepolicy
SOONG_CONFIG_NAMESPACES += sony_sm8650
SOONG_CONFIG_sony_sm8650 += module_priority
SOONG_CONFIG_sony_sm8650_module_priority := vendor/sony/sm8650-common
BOARD_SEPOLICY_M4DEFS += \
    sysfs_battery_supply=vendor_sysfs_battery_supply \
    sysfs_graphics=vendor_sysfs_graphics \
    sysfs_usb_supply=vendor_sysfs_usb_supply \
    display_vendor_data_file=vendor_display_vendor_data_file \
    hal_gnss_qti=vendor_hal_gnss_qti \
    hal_keymaster_qti_exec=vendor_hal_keymaster_qti_exec \
    hal_perf_default=vendor_hal_perf_default \
    location_domain=vendor_location \
    persist_block_device=vendor_persist_block_device \
    qdisplay_service=vendor_qdisplay_service
BOARD_SUPPORTS_OPENSOURCE_STHAL := false # Override from common

# Super Partition
BOARD_SUPER_PARTITION_SIZE := 10737418240
BOARD_SUPER_PARTITION_GROUPS := sony_dynamic_partitions
BOARD_SONY_DYNAMIC_PARTITIONS_SIZE := 8589934592
BOARD_SONY_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor odm system_dlkm vendor_dlkm
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop

# A/B Updates
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
    boot \
    dtbo \
    init_boot \
    odm \
    product \
    recovery \
    system \
    system_ext \
    system_dlkm \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_dlkm \
    vendor_boot

# Partition Sizes
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
TARGET_NO_INIT_BOOT := false
BOARD_FLASH_BLOCK_SIZE := 131072

# Init boot
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

# AVB Configuration
BOARD_AVB_ENABLE := true
TARGET_DESIRED_ROLLBACK_TIMESTAMP := 1743465600 # Corresponds to 2025-04-01

# Define the path where the public key for init_boot will be stored by the build system (REMOVING - no longer needed for explicit chain_partition)
# BOARD_AVB_INIT_BOOT_PUBKEY_PATH := $(PRODUCT_OUT)/avb_keys/init_boot.avbpubkey

BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS := \
    --flags 3 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --padding_size 4096

# Add these lines to explicitly include descriptors for dtbo and vendor_boot in vbmeta.img
# This tells vbmeta.img to hash the content of these partitions.
# Option 1: If your prebuilts dtbo.img and vendor_boot.img already contain the *exact*
#           hash descriptors you want vbmeta.img to use (meaning their footers are
#           already set up for vbmeta.img to consume directly).
# BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --include_descriptors_from_image $(PRODUCT_OUT)/dtbo.img
# BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --include_descriptors_from_image $(PRODUCT_OUT)/vendor_boot.img

# Option 2: If vbmeta.img should hash the raw content of the prebuilts found in $(PRODUCT_OUT)
#           This is generally what you want if BOARD_AVB_[PARTITION]_ADD_HASH_FOOTER_ARGS are empty.
#           The build system will calculate the hash of the content of $(PRODUCT_OUT)/dtbo.img
#           (which should be your untouched prebuilt) and $(PRODUCT_OUT)/vendor_boot.img.
# BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --include_hashtree_descriptor_from_prebuilt_image $(PRODUCT_OUT)/dtbo.img
# BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --include_hashtree_descriptor_from_prebuilt_image $(PRODUCT_OUT)/vendor_boot.img

# Directly Chained Partitions (from main vbmeta)
# Boot
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 3
BOARD_AVB_CHAIN_PARTITION_BOOT_VBMETA_ARGS := --flags 0 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
# Ensure RIL is in footer args as well, with literal flags
BOARD_AVB_BOOT_ADD_HASH_FOOTER_ARGS := --flags 3 --rollback_index $(BOARD_AVB_BOOT_ROLLBACK_INDEX) --rollback_index_location $(BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION) --algorithm $(BOARD_AVB_BOOT_ALGORITHM) --key $(BOARD_AVB_BOOT_KEY_PATH) --hash_algorithm sha256

# Init Boot - Configure to be built by the system with correct AVB Footer
# TARGET_PREBUILT_INIT_BOOT_IMAGE := $(DEVICE_PATH)/prebuilt_init_boot/init_boot.img # REMOVED - Let system build it

# These are for init_boot.img's own footer and for vbmeta.img to correctly create its chain descriptor
BOARD_AVB_INIT_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_INIT_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
_BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION_TEMP := 4 # For init_boot's footer RIL and vbmeta's chain descriptor RIL
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := $(strip $(_BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION_TEMP))

# Arguments for vbmeta.img's chain partition descriptor pointing to init_boot
BOARD_AVB_CHAIN_PARTITION_INIT_BOOT_VBMETA_ARGS := \
    --flags 0 \
    --rollback_index $(BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX)
    # The public key for chaining is implicitly taken from BOARD_AVB_INIT_BOOT_KEY_PATH.
    # The RIL for the chain descriptor will point to BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION.

# Tell the build system to add an AVB HASH footer to the init_boot.img it generates.
# Using _ADD_HASH_FOOTER_ARGS similar to boot.img and recovery.img
BOARD_AVB_INIT_BOOT_ADD_HASH_FOOTER_ARGS := \
    --flags 3 \
    --rollback_index $(BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX) \
    --rollback_index_location $(BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION) \
    --algorithm $(BOARD_AVB_INIT_BOOT_ALGORITHM) \
    --key $(BOARD_AVB_INIT_BOOT_KEY_PATH) \
    --hash_algorithm sha256

# BOARD_AVB_INIT_BOOT_ADD_HASHTREE_FOOTER_ARGS := # OLD - Ensure this is not set if using _ADD_HASH_FOOTER_ARGS
# BOARD_AVB_INIT_BOOT_FLAGS := # Clear any previous attempts to set this for the image's own footer

# Keep init boot mkbootimg args minimal, mainly for header version.
BOARD_MKBOOTIMG_INIT_ARGS := --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

# Recovery
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_CHAIN_PARTITION_RECOVERY_VBMETA_ARGS := --flags 0 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
# Ensure RIL is in footer args as well, with literal flags
BOARD_AVB_RECOVERY_ADD_HASH_FOOTER_ARGS := --flags 0 --rollback_index $(BOARD_AVB_RECOVERY_ROLLBACK_INDEX) --rollback_index_location $(BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION) --algorithm $(BOARD_AVB_RECOVERY_ALGORITHM) --key $(BOARD_AVB_RECOVERY_KEY_PATH) --hash_algorithm sha256

# DTBO - Configuration for Hashtree descriptor in main vbmeta
# The goal is for vbmeta.img to contain a hash of the dtbo partition,
# rather than chain to a dtbo.img that has its own AVB footer.
# BOARD_PREBUILT_DTBOIMAGE := kernel/sony/pdx245/prebuilts/dtbo.img # Ensure this is the stock dtbo_216.img content
# This matches the working configuration observed in my_super_final_vbmeta_v9.img.
# By not specifying a KEY_PATH or CHAIN_ARGS, and having dtbo in AB_OTA_PARTITIONS,
# the build system should default to creating a hash descriptor.
# Ensure build system does not add a footer to the prebuilt dtbo:
BOARD_AVB_DTBO_ADD_HASHTREE_FOOTER_ARGS :=
# BOARD_AVB_DTBO_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
# BOARD_AVB_DTBO_ALGORITHM := SHA256_RSA4096 # Commented out by previous edits
# BOARD_AVB_DTBO_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) # Commented out by previous edits
BOARD_AVB_DTBO_ROLLBACK_INDEX_LOCATION := 5 # Keep for vbmeta's reference if needed
# BOARD_AVB_CHAIN_PARTITION_DTBO_VBMETA_ARGS := --flags 3 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
# The following was the original BOARD_AVB_DTBO_ADD_HASHTREE_FOOTER_ARGS, now replaced by empty above.
# BOARD_AVB_DTBO_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) --rollback_index_location 5

# VBMeta System (chains logical partitions)
override BOARD_AVB_VBMETA_SYSTEM := system system_ext product odm vendor system_dlkm vendor_dlkm
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
# override BOARD_AVB_VBMETA_SYSTEM_FLAGS := 3 # Commenting this out to avoid conflict
# BOARD_AVB_VBMETA_SYSTEM_ADDITIONAL_ARGS := --flags 3 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
# Attempting a different variable to pass args directly to vbmeta_system.img creation
BOARD_AVB_MAKE_VBMETA_SYSTEM_IMAGE_ARGS := --flags 3 # Focus on flags here, RIL is handled by BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX

# Vendor Boot - Use prebuilt image. VBMeta will create a hash descriptor for this image as vendor is in AB_OTA_PARTITIONS.
# Ensure the prebuilt vendor_boot.img is the raw content if no separate footer is desired from build system.
TARGET_PREBUILT_VENDOR_BOOTIMAGE := $(DEVICE_PATH)/prebuilt_vendor_boot/vendor_boot.img # Ensure this is the desired prebuilt content
# BOARD_AVB_VENDOR_BOOT_ADD_HASHTREE_FOOTER_ARGS must be empty to use the raw prebuilt content for hashing.
# Other AVB args are cleared to prevent build system from adding a new footer or trying to chain it.
BOARD_AVB_VENDOR_BOOT_KEY_PATH :=
BOARD_AVB_VENDOR_BOOT_ALGORITHM :=
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX :=
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 6
BOARD_AVB_CHAIN_PARTITION_VENDOR_BOOT_VBMETA_ARGS :=
BOARD_AVB_VENDOR_BOOT_ADD_HASHTREE_FOOTER_ARGS :=

# Logical Partitions (hashed by vbmeta_system)
# System
BOARD_AVB_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_SYSTEM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_SYSTEM_ROLLBACK_INDEX_LOCATION := 13
BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) --rollback_index_location 13
BOARD_AVB_CHAIN_PARTITION_SYSTEM_VBMETA_ARGS := # Explicitly empty for main vbmeta

# Product
BOARD_AVB_PRODUCT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_PRODUCT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_PRODUCT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_PRODUCT_ROLLBACK_INDEX_LOCATION := 11
BOARD_AVB_PRODUCT_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) --rollback_index_location 11
BOARD_AVB_CHAIN_PARTITION_PRODUCT_VBMETA_ARGS := # Explicitly empty

# System Ext
BOARD_AVB_SYSTEM_EXT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_SYSTEM_EXT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_SYSTEM_EXT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_SYSTEM_EXT_ROLLBACK_INDEX_LOCATION := 12
BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) --rollback_index_location 12
BOARD_AVB_CHAIN_PARTITION_SYSTEM_EXT_VBMETA_ARGS := # Explicitly empty

# ODM
BOARD_AVB_ODM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_ODM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_ODM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_ODM_ROLLBACK_INDEX_LOCATION := 7
BOARD_AVB_ODM_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) --rollback_index_location 7
BOARD_AVB_CHAIN_PARTITION_ODM_VBMETA_ARGS := # Explicitly empty

# Vendor
BOARD_AVB_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_VENDOR_ROLLBACK_INDEX_LOCATION := 8
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) --rollback_index_location 8
BOARD_AVB_CHAIN_PARTITION_VENDOR_VBMETA_ARGS :=

# System DLKM
BOARD_AVB_SYSTEM_DLKM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_SYSTEM_DLKM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_SYSTEM_DLKM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_SYSTEM_DLKM_ROLLBACK_INDEX_LOCATION := 9
BOARD_AVB_SYSTEM_DLKM_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) --rollback_index_location 9
BOARD_AVB_CHAIN_PARTITION_SYSTEM_DLKM_VBMETA_ARGS :=

# Vendor DLKM
BOARD_AVB_VENDOR_DLKM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_DLKM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_DLKM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_VENDOR_DLKM_ROLLBACK_INDEX_LOCATION := 10
BOARD_AVB_VENDOR_DLKM_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) --rollback_index_location 10
BOARD_AVB_CHAIN_PARTITION_VENDOR_DLKM_VBMETA_ARGS :=

# Logical Partitions (hashed by vbmeta_system)

# VINTF additional configuration
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# Recovery in vendor_boot (standard flags)
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := false
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := false

# Force copy of prebuilt dtbo.img and vendor_boot.img to PRODUCT_OUT
# This ensures the versions vbmeta will hash are our known-good prebuilts.
PRODUCT_COPY_FILES += \
    kernel/sony/pdx245/prebuilts/dtbo.img:$(PRODUCT_OUT)/dtbo.img \
    $(DEVICE_PATH)/prebuilt_vendor_boot/vendor_boot.img:$(PRODUCT_OUT)/vendor_boot.img