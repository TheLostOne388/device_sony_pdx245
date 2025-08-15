# This file is included by the top-level Android build system.
# It allows us to add custom build steps and overrides.
CUSTOM_BUILD_VARS += PDX245_SECURITY_PATCH_OVERRIDE
PDX245_SECURITY_PATCH_OVERRIDE_VARS := \
    PLATFORM_SECURITY_PATCH \
    PLATFORM_VERSION_LAST_STABLE
PDX245_SECURITY_PATCH_OVERRIDE_FILE := $(DEVICE_PATH)/custom_build_vars.mk

# Inherit from common config first, so device-specific settings can override.
include device/sony/sm8650-common/BoardConfigCommon.mk

# Override LineageOS flag to allow our GKI prebuilt logic to work
TARGET_FORCE_PREBUILT_KERNEL := true
# Explicitly point to the GKI prebuilt kernel image for any logic that uses TARGET_PREBUILT_KERNEL
TARGET_PREBUILT_KERNEL := $(TOP)/kernel/prebuilts/6.6/arm64/kernel-6.6-gz

# Include BoardConfigSoong.mk early, before SOONG_CONFIG_NAMESPACES is modified by this file.
include vendor/lineage/config/BoardConfigSoong.mk

# Replace platform property.te to remove conflicting neverallow


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
# TARGET_COMPILE_WITH_MSM_KERNEL := true

DEVICE_PATH := device/sony/pdx245



# Execute pre-build sepolicy fix

TARGET_DESIRED_ROLLBACK_TIMESTAMP := 1743465600 # Corresponds to 2025-04-01

BOARD_USES_RECOVERY_AS_BOOT := false  # ensure init_boot.img is built
PRODUCT_REPACK_RECOVERY_IMAGES := false # Override from common to prevent conflicts

TARGET_VENDOR_PLATFORM_SECURITY_PATCH := 2025-04-01

# Enable Treble Support
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_VNDK_VERSION := current

# SELinux Configuration - Following LineageOS best practices
# BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive  # Testing enforcing mode
SELINUX_IGNORE_NEVERALLOWS := true  # TODO: Migrate to selective permissive domains

# Bypass sepolicy freeze test completely to allow 100% build completion
BUILD_BROKEN_TREBLE_SEPOLICY_TESTS := true
BUILD_BROKEN_SEPOLICY_TESTS := true
BUILD_BROKEN_ENFORCE_SEPOLICY_API := true
BUILD_BROKEN_SEPOLICY_FREEZE_TEST := true

# Conditional neverallow testing - uncomment to test specific improvements
# ifeq ($(TARGET_BUILD_VARIANT),eng)
#   SELINUX_IGNORE_NEVERALLOWS := false  # Test without ignoring in eng builds
# endif

# Future improvement: Replace global neverallow ignore with selective permissive domains
# This requires extensive testing to identify specific domains that need permissive mode
# Examples from QCOM: qti-testscripts, vendor_pdt_app, aoncameraservice_app, vendor_logkit_app

# Alternative approach: Use selective permissive domains instead of ignoring all neverallows
# This follows LineageOS pattern for better security

BOARD_KERNEL_CMDLINE += ramoops.mem_address=0xaff00000 ramoops.mem_size=0x100000 ramoops.record_size=0x10000 ramoops.console_size=0x10000

# Move vendor_dlkm out of vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USES_VENDOR_DLKMIMAGE := true
# BOARD_VENDOR_DLKMIMAGE_PARTITION_SIZE := 157286400  # 150MB instead of 100MB - Let build system auto-size
# NOTE: See vendor partition size note above.

# Ensure dmctl is built from source and included in recovery
# PRODUCT_PACKAGES += dmctl # Moved to device.mk

# Recovery partition configuration
BOARD_RECOVERY_FILESYSTEM_TYPE := f2fs
BOARD_ROOT_EXTRA_FOLDERS += metadata/ota
RECOVERY_VARIANT := lineage

# Ensure the full-featured dmctl is included in recovery for logical partitions
# TARGET_RECOVERY_DEVICE_MODULES += dmctl  # Moved to device.mk

TARGET_RELEASETOOLS_EXTENSIONS := $(DEVICE_PATH)/releasetools

# TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
# BOARD_USES_RECOVERY_AS_BOOT := true
# If you're using erofs (common in Android 15)
TARGET_USERIMAGES_USE_EROFS := false
TARGET_NO_RECOVERY := false # Ensure a recovery partition is built
# BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600
# NOTE: This is already defined in sm8650-common/BoardConfigCommon.mk (104857600)
# Uncommenting this would override the common value - only do if device-specific size needed
# Use common fstab instead of device-specific minimal one
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
TARGET_RECOVERY_INIT_RC := $(DEVICE_PATH)/recovery/root/init.rc

# Add lpmake and its rc script to recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    lpdump \
    lpflash \
    dmctl \
    liblp

# Exclude kernel from recovery image (ramdisk-only like stock)
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

# Use custom bootimg build to avoid automatic version arguments
# BOARD_CUSTOM_BOOTIMG_MK := $(DEVICE_PATH)/recovery/recovery_bootimg.mk
# BOARD_CUSTOM_BOOTIMG_MK += $(DEVICE_PATH)/recovery/boot_bootimg.mk
# BOARD_CUSTOM_BOOTIMG_MK += $(DEVICE_PATH)/recovery/init_boot_bootimg.mk # Removed for prebuilt init_boot

# Completely disable automatic OS version injection for all boot images
TARGET_RECOVERY_DISABLE_MKBOOTIMG_VERSION_ARGS := true
TARGET_BOOT_DISABLE_MKBOOTIMG_VERSION_ARGS := true
# TARGET_INIT_BOOT_DISABLE_MKBOOTIMG_VERSION_ARGS := true

# Clear problematic args that interfere with custom makefiles
BOARD_RECOVERY_MKBOOTIMG_ARGS := # Revert to empty
# Revert to minimal boot image arguments, removing the offsets that caused boot failures.
# The stock bootloader does not expect these custom offsets.
BOARD_MKBOOTIMG_ARGS += --cmdline "$(BOARD_KERNEL_CMDLINE)"

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

# DTB/DTBO Configuration
#
# DTB (Device Tree Blob - the base hardware tree for GKI)
# This ensures the correct prebuilt DTB is included in the vendor_boot image,
# which is required for the GKI kernel to boot correctly.
BOARD_INCLUDE_DTB_IN_BOOTIMG := false
BOARD_PREBUILT_DTBIMAGE := $(TOP)/kernel/sony/pdx245/prebuilts/dtb.img
BOARD_INCLUDE_DTB_IN_VENDOR_BOOT := true
#
# DTBO (Device Tree Blob Overlay)
# We use a prebuilt dtbo.img and configure AVB to create a hash descriptor for it.
BOARD_KERNEL_SEPARATED_DTBO :=
BOARD_PREBUILT_DTBOIMAGE := $(TOP)/kernel/sony/pdx245/prebuilts/dtbo.img

# Offsets for boot.img contents are being removed as they caused boot failures.
# The stock bootloader does not expect custom offsets in the boot.img header.
# BOARD_KERNEL_OFFSET      := 0x00008000

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

# Use custom makefile hook to restore stock dtbo with footer
# BOARD_CUSTOM_DTBOIMG_MK := $(DEVICE_PATH)/dtbo_prebuilt.mk

# DLKM Images - These might need to come from crDroid GKI prebuilts too, or be rebuilt.
# For now, keeping Sony ones. If errors, investigate kernel/prebuilts/6.1/arm64/system_dlkm_staging/
# BOARD_PREBUILT_SYSTEM_DLKM := $(TOP)/kernel/sony/pdx245/prebuilts/system_dlkm.img # Commented out to allow build from GKI modules
# BOARD_PREBUILT_VENDOR_DLKM := $(TOP)/kernel/sony/pdx245/prebuilts/vendor_dlkm.img # REMOVED to enable GKI-compliant source build

# Vendor Boot - Let this build from source. The "dtb size: 0" is not an error.
# The DTB is correctly sourced from the dtbo partition.
# By removing the TARGET_PREBUILT_VENDOR_BOOT_IMAGE and related AVB signing flags,
# we instruct the build system to treat vendor_boot as a simple HASHED partition in vbmeta,
# which aligns with the modern configuration observed in the Pixel "caiman" dump.
# TARGET_PREBUILT_VENDOR_BOOT_IMAGE := $(DEVICE_PATH)/prebuilt_vendor_boot/vendor_boot.img

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

# Disable sepolicy freeze test for custom ROM compatibility
BUILD_BROKEN_SEPOLICY_FREEZE_TEST := true
BUILD_BROKEN_TREBLE_SEPOLICY_TESTS := true
BUILD_BROKEN_SEPOLICY_BUILD := true
BOARD_SEPOLICY_M4DEFS += BUILD_BROKEN_SEPOLICY_FREEZE_TEST=true

BOARD_SEPOLICY_M4DEFS += module_data_oem=true wifi_qcom_regdom=true

# Policy Pinning - Use Android 14 platform policy for vendor compatibility
PLATFORM_SEPOLICY_VERSION := 34.0
BOARD_SEPOLICY_M4DEFS += PLATFORM_SEPOLICY_VERSION=34.0

# crDroid 11 specific flags
CRDROID_OFFICIAL := false
CRDROID_MAINTAINER := erik
TARGET_FACE_UNLOCK_SUPPORTED := true

# Sepolicy configuration for crDroid
BOARD_SEPOLICY_M4DEFS += sony_device=pdx245
BOARD_SEPOLICY_M4DEFS += qcom_platform=sm8650
BOARD_SEPOLICY_M4DEFS += crdroid_version=11
BOARD_SEPOLICY_M4DEFS += qcom_battery_supply=true


BOARD_SEPOLICY_DIRS += device/qcom/sepolicy-legacy-um/vendor/common
BOARD_SEPOLICY_DIRS += device/qcom/sepolicy-legacy-um/vendor/sm8650
# BOARD_SEPOLICY_DIRS += device/sony/pdx245/sepolicy/public
BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy
BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
BOARD_SEPOLICY_DIRS += device/crdroid/sepolicy/common

# Add device-specific system_ext sepolicy overrides
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/sony/pdx245/sepolicy/system_ext/public
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/sony/pdx245/sepolicy/system_ext/private

# Super Partition
BOARD_SUPER_PARTITION_SIZE := 10737418240
BOARD_SUPER_PARTITION_GROUPS := sony_dynamic_partitions
BOARD_SONY_DYNAMIC_PARTITIONS_SIZE := 8589934592
BOARD_SONY_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor odm system_dlkm vendor_dlkm

BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
# BOARD_VENDORIMAGE_PARTITION_SIZE := 2415919104 # 2.25GB - Let build system auto-size
# NOTE: Explicitly defining sizes for logical partitions is discouraged when a group size
# is defined, as it can lead to mismatches between the generated filesystem and the
# AVB hashtree descriptor. The build system will auto-size these based on content.

TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop

# A/B Updates
AB_OTA_UPDATER := true

# Minimal dummy post-install step to satisfy payload generator
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/true \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true \
    RUN_POSTINSTALL_vendor=false \
    FILESYSTEM_TYPE_vendor=ext4 \
    RUN_POSTINSTALL_product=false \
    FILESYSTEM_TYPE_product=ext4

# This list determines which partitions are included in OTA packages and what
# partitions vbmeta will create descriptors for.
# Chained partitions should be here.
# HASHED partitions (dtbo, vendor_boot) MUST ALSO be here for vbmeta to create hash descriptors.
AB_OTA_PARTITIONS := \
    system \
    system_ext \
    product \
    vendor \
    odm \
    system_dlkm \
    vendor_dlkm \
    boot \
    init_boot \
    vbmeta \
    vbmeta_system \
    recovery \
    dtbo \
    vendor_boot

# Partition Sizes
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
# DTBO partition – real slot size is 24 MiB (0x01800000 = 25 165 824 bytes)
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
# BOARD_DTBOIMAGE_PARTITION_SIZE := 25165824   # (old variable name – ignored by Soong)

# vendor_boot slot on-device is 96 MiB (0x06000000 = 100 663 296 bytes)
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
TARGET_NO_INIT_BOOT := false
BOARD_FLASH_BLOCK_SIZE := 131072

# Init boot
BOARD_INIT_BOOT_HEADER_VERSION := 3
# BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

BOARD_BUILD_DISABLED_VBMETAIMAGE := true

# AVB has been fully disabled to simplify boot process debugging.
# All vbmeta generation and signing is turned off.
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS :=
include $(DEVICE_PATH)/avb_config2.mk

# include $(DEVICE_PATH)/avb_config2.mk  # AVB Disabled
TARGET_RECOVERY_UTILS_PROGS += fsck.f2fs f2fsresize mkfs.f2fs
# Enable logical-partition tools in recovery ramdisk
BOARD_BUILD_RECOVERY_DYNAMIC_PARTITION := true
TARGET_RECOVERY_DEVICE_MODULES += lpdump lpflash dmctl

# Statically include filesystem tools in recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    e2fsck \
    mke2fs \
    tune2fs \
    resize2fs \
    blkid \
    fsck.f2fs \
    make_f2fs \
    sload_f2fs

BOARD_RECOVERY_SEPOLICY_DIRS += device/sony/pdx245/sepolicy/recovery

# GKI v4 layout fix - omit ramdisk from boot.img
BOARD_EXCLUDE_KERNEL_RAMDISK := true

# Match stock uncompressed kernel
BOARD_KERNEL_COMPRESSION := none

# GKI v4 layout
BOARD_BOOTIMG_HEADER_VERSION := 4
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_EXCLUDE_KERNEL_RAMDISK := true
# BOARD_BUILD_INIT_BOOT_IMAGE := true
#BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_RAMDISK_USE_LZ4 := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := false
BOARD_KERNEL_CMDLINE += androidboot.force_normal_boot=1 ramoops.mem_address=0xFFE00000 ramoops.mem_size=0xC0000 ramoops.record_size=0x8000 ramoops.console_size=0x8000 earlycon=qcom_geni_serial console=ttyMSM0,115200,n8

# Disable building host tools for other operating systems
HOST_CROSS_OS := 
TARGET_PROVIDES_LIBAR_PAL := true

# Ensure we use prebuilt audio components
TARGET_USES_QCOM_BSP := true
BOARD_USES_QCOM_HARDWARE := true

# Disable LineageOS's CAF audio HAL to prevent conflicts with Sony's prebuilts
USE_DEVICE_SPECIFIC_AUDIO := true
DEVICE_SPECIFIC_AUDIO_PATH := device/sony/pdx245/audio

# Disable LineageOS's CAF display HAL to prevent conflicts with Sony's prebuilts
USE_DEVICE_SPECIFIC_DISPLAY := true
DEVICE_SPECIFIC_DISPLAY_PATH := device/sony/pdx245/display

# Disable LineageOS's CAF WLAN HAL to prevent conflicts with Sony's prebuilts
USE_DEVICE_SPECIFIC_WLAN := true
DEVICE_SPECIFIC_WLAN_PATH := device/sony/pdx245/wlan

# Disable LineageOS's CAF Bluetooth HAL to prevent conflicts with Sony's prebuilts
USE_DEVICE_SPECIFIC_BT_VENDOR := true
DEVICE_SPECIFIC_BT_VENDOR_PATH := device/sony/pdx245/bt

# Disable LineageOS's CAF media HAL to prevent conflicts with Sony's prebuilts
USE_DEVICE_SPECIFIC_MEDIA := true
DEVICE_SPECIFIC_MEDIA_PATH := device/sony/pdx245/media

# DATA_IPA_CFG_MGR (Data/Connectivity)
USE_DEVICE_SPECIFIC_DATA_IPA_CFG_MGR := true
DEVICE_SPECIFIC_DATA_IPA_CFG_MGR_PATH := device/sony/pdx245/data

# DATASERVICES
USE_DEVICE_SPECIFIC_DATASERVICES := true
DEVICE_SPECIFIC_DATASERVICES_PATH := device/sony/pdx245/dataservices