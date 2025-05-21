CUSTOM_BUILD_VARS += PDX245_SECURITY_PATCH_OVERRIDE
PDX245_SECURITY_PATCH_OVERRIDE_VARS := \
    PLATFORM_SECURITY_PATCH \
    PLATFORM_VERSION_LAST_STABLE
PDX245_SECURITY_PATCH_OVERRIDE_FILE := $(DEVICE_PATH)/custom_build_vars.mk

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
BOARD_EXCLUDE_QCOM_AUDIO_PAL := true

# TARGET_BOARD_PLATFORM already defined in BoardConfigCommon.mk
TARGET_COMPILE_WITH_MSM_KERNEL := true

DEVICE_PATH := device/sony/pdx245
-include device/sony/sm8650-common/BoardConfigCommon.mk

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
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_NO_RECOVERY := false # Ensure a recovery partition is built
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600 # Match stock 100MiB

# Display
TARGET_SCREEN_DENSITY := 450

# Props
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

BOARD_USES_VENDOR_DLKM := true

# Define base kernel path
_KERNEL_PREBUILT_DIR_TEMP := $(TOP)/kernel/sony/pdx245/prebuilts
KERNEL_PREBUILT_DIR := $(strip $(_KERNEL_PREBUILT_DIR_TEMP))

# Kernel Configuration
TARGET_NO_KERNEL := false # As per LKG
BOARD_KERNEL_IMAGE_NAME := Image # Though TARGET_NO_KERNEL is false, INSTALLED_KERNEL_TARGET points to prebuilt
INSTALLED_KERNEL_TARGET := $(KERNEL_PREBUILT_DIR)/Image
BOARD_KERNEL_CONFIG_FILE := $(KERNEL_PREBUILT_DIR)/kernel.config
_BOARD_KERNEL_VERSION_TEMP := 6.1.43-android14-11-gf1a3cfb97a68-ab12168211
BOARD_KERNEL_VERSION := $(strip $(_BOARD_KERNEL_VERSION_TEMP))

# Kernel Headers
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_BOARD_KERNEL_HEADERS := $(KERNEL_PREBUILT_DIR)/kernel-headers
TARGET_NO_KERNEL_HEADERS := true
TARGET_USE_PREBUILT_KERNEL_HEADERS := true
BOARD_VENDOR_KERNEL_HEADERS := $(KERNEL_PREBUILT_DIR)/kernel-headers
BOARD_PREBUILT_KERNEL_HEADERS := $(KERNEL_PREBUILT_DIR)/kernel-headers
TARGET_SPECIFIC_HEADER_PATH += $(KERNEL_PREBUILT_DIR)/kernel-headers

# Define the header library that other modules can depend on
BOARD_HEADER_LIBRARIES += \
    generated_kernel_headers \
    qti_kernel_headers

# Make sure Soong can find the headers
SOONG_CONFIG_NAMESPACES += kernel_headers
SOONG_CONFIG_kernel_headers += kernel_headers_path
SOONG_CONFIG_kernel_headers_kernel_headers_path := $(KERNEL_PREBUILT_DIR)/kernel-headers

# DTB/DTBO Configuration
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE := $(KERNEL_PREBUILT_DIR)/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PREBUILT_DIR)/dtbo.img # This is the raw stock content
BOARD_KERNEL_SEPARATED_DTBO := true

# DLKM Images
BOARD_PREBUILT_SYSTEM_DLKM := $(KERNEL_PREBUILT_DIR)/system_dlkm.img
BOARD_PREBUILT_VENDOR_DLKM := $(KERNEL_PREBUILT_DIR)/vendor_dlkm.img

# Vendor Boot modules
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(TOP)/vendor/sony/pdx245/proprietary/vendor/lib/modules/modules.load

# Use prebuilt stock vendor_boot.img
BOARD_PREBUILT_VENDOR_BOOTIMAGE := $(DEVICE_PATH)/prebuilt_vendor_boot/vendor_boot.img # Ensure stock vendor_boot_216.img is here

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
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
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
    vendor_boot \
    vendor_dlkm

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

# Main vbmeta.img
# The key path defaults to external/avb/test/data/testkey_rsa4096.pem if not specified
# BOARD_AVB_KEY_PATH could be set here if a different main key is desired for vbmeta.img
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS := \
    --flags 3 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --padding_size 4096

# Directly Chained Partitions (from main vbmeta)
# Boot
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 3
BOARD_AVB_CHAIN_PARTITION_BOOT_VBMETA_ARGS := --flags 3 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_BOOT_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256

# Init Boot
BOARD_AVB_INIT_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_INIT_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := 4
BOARD_AVB_CHAIN_PARTITION_INIT_BOOT_VBMETA_ARGS := --flags 3 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_INIT_BOOT_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256

# Recovery
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_CHAIN_PARTITION_RECOVERY_VBMETA_ARGS := --flags 0 --rollback_index $(BOARD_AVB_RECOVERY_ROLLBACK_INDEX)
BOARD_AVB_RECOVERY_ADD_HASHTREE_FOOTER_ARGS := --flags 0 --hash_algorithm sha256 --rollback_index $(BOARD_AVB_RECOVERY_ROLLBACK_INDEX)

# DTBO - Uses BOARD_PREBUILT_DTBOIMAGE. Footer added by build system.
BOARD_AVB_DTBO_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_DTBO_ALGORITHM := SHA256_RSA4096
BOARD_AVB_DTBO_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_DTBO_ROLLBACK_INDEX_LOCATION := 5
BOARD_AVB_CHAIN_PARTITION_DTBO_VBMETA_ARGS := --flags 3 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_DTBO_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)

# VBMeta System (chains logical partitions)
override BOARD_AVB_VBMETA_SYSTEM := system system_ext product odm vendor system_dlkm vendor_dlkm
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
BOARD_AVB_VBMETA_SYSTEM_ADDITIONAL_ARGS := --flags 3 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)

# Vendor Boot - Uses BOARD_PREBUILT_VENDOR_BOOTIMAGE (stock, footerless).
# AVB variables are cleared to prevent build system from adding footer/chaining.
BOARD_AVB_VENDOR_BOOT_KEY_PATH :=
BOARD_AVB_VENDOR_BOOT_ALGORITHM :=
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX :=
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 6 # Dummy value for Soong, but no AVB processing
BOARD_AVB_CHAIN_PARTITION_VENDOR_BOOT_VBMETA_ARGS :=
BOARD_AVB_VENDOR_BOOT_ADD_HASHTREE_FOOTER_ARGS :=

# Logical Partitions (hashed by vbmeta_system) - AVB processing temporarily disabled for diagnostics
# System
BOARD_AVB_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_SYSTEM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_SYSTEM_ROLLBACK_INDEX_LOCATION := 13 # Ensure this is unique
BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_CHAIN_PARTITION_SYSTEM_VBMETA_ARGS := # Explicitly empty for main vbmeta

# Product
BOARD_AVB_PRODUCT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_PRODUCT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_PRODUCT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_PRODUCT_ROLLBACK_INDEX_LOCATION := 11 # Unique RIL
BOARD_AVB_PRODUCT_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_CHAIN_PARTITION_PRODUCT_VBMETA_ARGS := # Explicitly empty

# System Ext
BOARD_AVB_SYSTEM_EXT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_SYSTEM_EXT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_SYSTEM_EXT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_SYSTEM_EXT_ROLLBACK_INDEX_LOCATION := 12 # Unique RIL
BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_CHAIN_PARTITION_SYSTEM_EXT_VBMETA_ARGS := # Explicitly empty

# ODM
BOARD_AVB_ODM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_ODM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_ODM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_ODM_ROLLBACK_INDEX_LOCATION := 7 # Unique RIL
BOARD_AVB_ODM_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_CHAIN_PARTITION_ODM_VBMETA_ARGS := # Explicitly empty

# Vendor
BOARD_AVB_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_VENDOR_ROLLBACK_INDEX_LOCATION := 8
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_CHAIN_PARTITION_VENDOR_VBMETA_ARGS :=

# System DLKM
BOARD_AVB_SYSTEM_DLKM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_SYSTEM_DLKM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_SYSTEM_DLKM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_SYSTEM_DLKM_ROLLBACK_INDEX_LOCATION := 9
BOARD_AVB_SYSTEM_DLKM_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_CHAIN_PARTITION_SYSTEM_DLKM_VBMETA_ARGS :=

# Vendor DLKM
BOARD_AVB_VENDOR_DLKM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_DLKM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_DLKM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_VENDOR_DLKM_ROLLBACK_INDEX_LOCATION := 10
BOARD_AVB_VENDOR_DLKM_ADD_HASHTREE_FOOTER_ARGS := --flags 3 --hash_algorithm sha256 --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_CHAIN_PARTITION_VENDOR_DLKM_VBMETA_ARGS :=

# VINTF additional configuration
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# Recovery in vendor_boot (standard flags)
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := false
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := false