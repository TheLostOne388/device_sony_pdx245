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

# TARGET_BOARD_PLATFORM already defined in BoardConfigCommon.mk
TARGET_COMPILE_WITH_MSM_KERNEL := true

# BOARD_USES_QCOM_HARDWARE is already defined in BoardConfigCommon.mk

# Enable Treble Support
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_SEPARATE_VENDOR := true
BOARD_VNDK_VERSION := current
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := 1610612736
BOARD_HAS_VENDOR_PARTITION := true
BOARD_BUILD_VENDOR_IMAGE := true

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
BOARD_PREBUILT_RAMDISK := $(KERNEL_PREBUILT_DIR)/ramdisk.cpio

# DLKM Images
BOARD_PREBUILT_SYSTEM_DLKM := $(KERNEL_PREBUILT_DIR)/system_dlkm.img
BOARD_PREBUILT_VENDOR_DLKM := $(KERNEL_PREBUILT_DIR)/vendor_dlkm.img

# Kernel Modules
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(KERNEL_PREBUILT_DIR)/modules.load
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(KERNEL_PREBUILT_DIR)/*.ko)

TARGET_DEVICE := pdx245

# Claude Made Me Do It
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
    
TARGET_SEPOLICY_DIR := sm8550

DEVICE_PATH := device/sony/pdx245
-include device/sony/sm8650-common/BoardConfigCommon.mk

# Base device manifest
DEVICE_MANIFEST_FILE := \
#    $(DEVICE_PATH)/vintf/manifest.xml 
#    device/sony/sm8650-common/manifest.xml \
#    device/sony/sm8650-common/network_manifest.xml

# SKU-specific manifests
DEVICE_MANIFEST_SKUS := pdx245
DEVICE_MANIFEST_PDX245_FILES := \
    vendor/sony/sm8650-common/proprietary/vendor/etc/vintf/manifest/manifest_pineapple.xml \
    vendor/sony/pdx245/proprietary/vendor/etc/vintf/manifest/android.hardware.boot.xml

# Use our custom framework compatibility matrices - alternative file as a test
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/vintf/device_framework_compatibility_matrix.xml

# Override the common declaration
override DEVICE_MATRIX_FILE := \
    $(DEVICE_PATH)/vintf/device_compatibility_matrix.xml

# Set FCM Version for VINTF compatibility
BOARD_SHIPPING_API_LEVEL := 34
BOARD_SHIPPING_FCM_VERSION := 8
BOARD_SYSTEMSDK_VERSIONS := 34 35
BOARD_SEPOLICY_VERS := 30
PLATFORM_SEPOLICY_VERSION := 202404
BOARD_SEPOLICY_VERS_API := 30

# Set POLICYVERS as a Soong config variable
SOONG_CONFIG_NAMESPACES += vintf 
SOONG_CONFIG_vintf += POLICYVERS
SOONG_CONFIG_vintf_POLICYVERS := 30

# Map vendor types to system types
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/lineage/sepolicy/qcom/vendor

# Add your vendor tree to the Soong search path
BOARD_VENDOR_SEPOLICY_DIRS += vendor/sony/sm8650-common/sepolicy

# Register and prioritize the namespace
SOONG_CONFIG_NAMESPACES += sony_sm8650
SOONG_CONFIG_sony_sm8650 += module_priority
SOONG_CONFIG_sony_sm8650_module_priority := vendor/sony/sm8650-common

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/lineage/sepolicy/qcom/private

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += \
    device/lineage/sepolicy/qcom/public

# Define the M4 macros directly without recursive definitions
BOARD_SEPOLICY_M4DEFS += \
    vendor_sysfs_battery_supply=sysfs_battery_supply \
    vendor_sysfs_graphics=sysfs_graphics \
    vendor_sysfs_usb_supply=sysfs_usb_supply \
    display_vendor_data_file=vendor_display_data_file \
    hal_gnss_qti=hal_gnss_vendor \
    hal_keymaster_qti_exec=vendor_hal_keymaster_qti_exec \
    hal_perf_default=vendor_hal_perf_default \
    location_domain=vendor_location \
    persist_block_device=vendor_persist_block_device \
    qdisplay_service=vendor_qdisplay_service

# Audio
# These override the BoardConfigCommon.mk settings
BOARD_SUPPORTS_OPENSOURCE_STHAL := false

BOARD_SEPOLICY_DIRS += vendor/sony/pdx245/sepolicy
BOARD_SEPOLICY_REPLACE += vendor_sepolicy.cil vendor_file_contexts

include $(DEVICE_PATH)/audio/audio_effects.mk
include $(DEVICE_PATH)/audio/audio_primary.mk
