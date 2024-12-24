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

# Inherit from sony sm8650-common
-include device/sony/sm8650-common/BoardConfigCommon.mk

# Enable Treble Support
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_SEPARATE_VENDOR := true
BOARD_VNDK_VERSION := current
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := 1610612736
BOARD_HAS_VENDOR_PARTITION := true
BOARD_BUILD_VENDOR_IMAGE := true

# Device Path
DEVICE_PATH := device/sony/pdx245

# Device Manifest
DEVICE_MANIFEST_FILE += device/sony/sm8650-common/configs/manifest_graphics.xml

# Display
TARGET_SCREEN_DENSITY := 420

# Props
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Kernel Configuration
KERNEL_PATH := kernel/sony/pdx245-kernel/prebuilts

# Kernel build configuration
TARGET_NO_KERNEL := false
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_KERNEL_SOURCE := kernel/sony/pdx245-kernel

# Kernel Header Configuration
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_BOARD_KERNEL_HEADERS := $(KERNEL_PATH)/kernel-headers
TARGET_CUSTOM_KERNEL_HEADERS := $(KERNEL_PATH)/kernel-headers
TARGET_KERNEL_HEADERS := $(KERNEL_PATH)/kernel-headers
TARGET_VENDOR_KERNEL_HEADERS := $(KERNEL_PATH)/kernel-headers

# Disable all kernel build options
BUILD_KERNEL_HEADERS := false
NEED_KERNEL_MODULE_SYSTEM := false
BUILD_BROKEN_KERNEL_MODULES := true
BUILD_KERNEL_MODULES := false
TARGET_NO_KERNEL_MODULES := true

# Basic kernel config
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_DTB_OFFSET := 0x01f00000

# Prebuilt kernel configuration
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/Image
BOARD_KERNEL_IMAGE_NAME := Image

# DTB/DTBO
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE := $(KERNEL_PATH)/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img
BOARD_MKBOOTIMG_ARGS += --dtb $(KERNEL_PATH)/dtb.img

# Kernel Modules
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/*.ko)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat vendor/sony/pdx245/proprietary/vendor/lib/modules/modules.load))

# Override kernel header generation
PRODUCT_SOONG_NAMESPACES += \
    vendor/lineage \
    kernel/sony/pdx245-kernel

# Copy prebuilt headers to generated location
# $(shell mkdir -p $(GENERATED_KERNEL_HEADERS))
# $(shell cp -r $(KERNEL_PATH)/kernel-headers/* $(GENERATED_KERNEL_HEADERS)/)

# SELinux
include device/qcom/sepolicy_vndr/SEPolicy.mk

BOARD_VENDOR_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy/vendor \
    vendor/sony/pdx245/proprietary/vendor/etc/selinux \
    device/qcom/sepolicy_vndr/sm8550/generic/vendor/common \
    device/qcom/sepolicy_vndr/sm8550/generic/vendor/kalama \
    device/qcom/sepolicy_vndr/sm8550/qva/vendor/common \
    device/qcom/sepolicy_vndr/sm8550/qva/vendor/kalama \
    device/lineage/sepolicy/qcom/vendor

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/lineage/sepolicy/common/private \
    device/lineage/sepolicy/qcom/dynamic \
    device/lineage/sepolicy/qcom/private \
    $(DEVICE_PATH)/sepolicy/private

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += \
    device/lineage/sepolicy/common/public \
    device/sony/pdx245/sepolicy/public

# Move your attributes.te to the vendor directory
BOARD_VENDOR_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy/vendor