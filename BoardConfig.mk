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

# Enable Treble Support
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_VNDK_VERSION := current

# Move vendor_dlkm out of vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USES_VENDOR_DLKMIMAGE := true
BOARD_VENDOR_DLKMIMAGE_PARTITION_SIZE := 157286400  # 150MB instead of 100MB

# Recovery partition configuration
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_NO_RECOVERY := true

# Display
TARGET_SCREEN_DENSITY := 396

# Props
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

BOARD_USES_VENDOR_DLKM := true

# Define base kernel path
KERNEL_PREBUILT_DIR := $(TOP)/kernel/sony/pdx245/prebuilts

# Kernel Configuration
TARGET_NO_KERNEL := false
INSTALLED_KERNEL_TARGET := $(KERNEL_PREBUILT_DIR)/Image
BOARD_KERNEL_CONFIG_FILE := $(KERNEL_PREBUILT_DIR)/kernel.config
BOARD_KERNEL_VERSION := 6.1.43-android14-11-gf1a3cfb97a68-ab12168211

# Kernel Headers
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_BOARD_KERNEL_HEADERS := $(KERNEL_PREBUILT_DIR)/kernel-headers

TARGET_NO_KERNEL_HEADERS := true 

TARGET_USE_PREBUILT_KERNEL_HEADERS := true
BOARD_VENDOR_KERNEL_HEADERS := $(KERNEL_PREBUILT_DIR)/kernel-headers
BOARD_PREBUILT_KERNEL_HEADERS := $(KERNEL_PREBUILT_DIR)/kernel-headers

# Add system-wide kernel header paths
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
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PREBUILT_DIR)/dtbo.img
BOARD_KERNEL_SEPARATED_DTBO := true

# Ramdisk Configuration
## BOARD_PREBUILT_RAMDISK := $(KERNEL_PREBUILT_DIR)/ramdisk.cpio

# DLKM Images
BOARD_PREBUILT_SYSTEM_DLKM := $(KERNEL_PREBUILT_DIR)/system_dlkm.img
BOARD_PREBUILT_VENDOR_DLKM := $(KERNEL_PREBUILT_DIR)/vendor_dlkm.img

# Kernel Modules
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(KERNEL_PREBUILT_DIR)/modules.load
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(KERNEL_PREBUILT_DIR)/*.ko)

TARGET_DEVICE := pdx245


TARGET_SPECIFIC_HEADER_PATH := \
    frameworks/av/media/module/foundation/include \
    frameworks/av/media/module/libmediatranscoding/transcoder/include \
    frameworks/av/media/libmediametrics/include \
    frameworks/native/include \
    system/libbase/include \
    frameworks/av/include \
    frameworks/av/media/libstagefright/include \
    frameworks/native/libs/nativebase/include \
    frameworks/native/libs/nativewindow/include \
    frameworks/av/media/ndk/include \
    device/sony/pdx245/include \
    vendor/qcom/opensource/usb/hal \
    vendor/qcom/opensource/usb/hal/aidl \
    frameworks/av/media/libmedia/include \
    hardware/interfaces/bluetooth/audio/2.0 \
    hardware/interfaces/bluetooth/audio/2.1 
    
TARGET_SEPOLICY_DIR := sm8650

# Override the common declaration
override DEVICE_MATRIX_FILE := \
    $(DEVICE_PATH)/vintf/device_compatibility_matrix.xml

# Override the common declaration
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    $(DEVICE_PATH)/vintf/lineage_compat_matrix.xml \
    $(DEVICE_PATH)/vintf/device_framework_compatibility_matrix.xml \
    $(DEVICE_PATH)/vintf/device_framework_compatibility_matrix2.xml

# VINTF Configuration
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/vintf/manifest.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := $(DEVICE_PATH)/vintf/framework_manifest.xml
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/vintf/compatibility_matrix.device.xml
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# Add flag to handle vendor manifest level mismatch
BUILD_BROKEN_VINTF_LEVEL_MISMATCH := true

# Sepolicy version settings
BOARD_SHIPPING_API_LEVEL := 34
BOARD_SHIPPING_FCM_VERSION := 8 # Keep Level 8
BOARD_SYSTEMSDK_VERSIONS := 34 35
BOARD_SEPOLICY_VERS := 34.0 # Match vendor manifest
BOARD_SEPOLICY_VERS_API := 34 # Align API level for sepolicy
PLATFORM_SEPOLICY_COMPAT_VERSIONS := 29.0 30.0 31.0 32.0 33.0 34.0 # Ensure 34.0 is present

# Custom hook to fix sepolicy compatibility issues
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true
BUILD_BROKEN_VINTF_VALIDATES_SEPOLICY_VERSION := true

BOARD_SEPOLICY_M4DEFS += module_dataoem=true
BOARD_SEPOLICY_M4DEFS += wifi_qcom_regdom=true

# Load our fixed sepolicy directory first
include device/sony/pdx245/sepolicy_fixed/sepolicy.mk

# Then load dynamic definitions (which may include type declarations)
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/lineage/sepolicy/qcom/dynamic

# Add vendor tree to the Soong search path (last to avoid conflicts)
BOARD_VENDOR_SEPOLICY_DIRS += vendor/sony/sm8650-common/sepolicy

# Register and prioritize the namespace
SOONG_CONFIG_NAMESPACES += sony_sm8650
SOONG_CONFIG_sony_sm8650 += module_priority
SOONG_CONFIG_sony_sm8650_module_priority := vendor/sony/sm8650-common

# Define the M4 macros directly without recursive definitions
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

# These override the BoardConfigCommon.mk settings
BOARD_SUPPORTS_OPENSOURCE_STHAL := false

# Remove legacy sepolicy paths
BOARD_VENDOR_SEPOLICY_DIRS := $(filter-out vendor/sony/pdx245/sepolicy,$(BOARD_VENDOR_SEPOLICY_DIRS))
BOARD_SEPOLICY_REPLACE := $(filter-out vendor_sepolicy.cil vendor_file_contexts,$(BOARD_SEPOLICY_REPLACE))

# Super partition configuration for dynamic partitions
BOARD_SUPER_PARTITION_SIZE := 10737418240  # 10 GB
BOARD_SUPER_PARTITION_GROUPS := sony_dynamic_partitions
BOARD_SONY_DYNAMIC_PARTITIONS_SIZE := 8589934592  # 8 GB
BOARD_SONY_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor odm system_dlkm vendor_dlkm

# Vendor partition configuration
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs

# Product props
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop

# A/B partition configuration for seamless updates
AB_OTA_UPDATER := true
TARGET_NO_RECOVERY := true
AB_OTA_PARTITIONS := \
    boot \
    dtbo \
    init_boot \
    odm \
    product \
    system \
    system_ext \
    system_dlkm \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot \
    vendor_dlkm


# Boot and related partition sizes
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296  # ~96 MB
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296  # ~96 MB (was 117440512)
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608 # ~8 MB
TARGET_NO_INIT_BOOT := true
BOARD_FLASH_BLOCK_SIZE := 131072

# Init boot configuration
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true


# AVB configuration for init_boot
BOARD_AVB_INIT_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_INIT_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := 4

# Recovery settings
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# Vendor DLKM configuration
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_PARTITION_SIZE := 104857600  # 100 MB
BOARD_PREBUILT_VENDOR_DLKM := $(KERNEL_PREBUILT_DIR)/vendor_dlkm.img
BOARD_PREBUILT_SYSTEM_DLKM := $(KERNEL_PREBUILT_DIR)/system_dlkm.img

# VINTF additional configuration
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# AVB
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 3

# AVB configuration for vbmeta_system
BOARD_AVB_VBMETA_SYSTEM := system system_ext system_dlkm
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --include_descriptors_from_image $(PRODUCT_OUT)/vbmeta_system.img

# Use 202404 version for compatibility with newer Android versions
