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

#Enable Treble Support
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_SEPARATE_VENDOR := true
BOARD_VNDK_VERSION := current
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := 1610612736

BOARD_HAS_VENDOR_PARTITION := true
BOARD_BUILD_VENDOR_IMAGE := true

DEVICE_PATH := device/sony/pdx245

# Display
TARGET_SCREEN_DENSITY := 420

# Props
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Inherit from the proprietary version
-include vendor/sony/pdx245/BoardConfigVendor.mk

# Kernel Configuration
TARGET_KERNEL_PREBUILT := kernel/sony/pdx245-kernel/prebuilts/Image
TARGET_KERNEL_USE_PREBUILT := true
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_NO_KERNEL_OVERRIDE := true
BOARD_PREBUILT_DTBIMAGE := kernel/sony/pdx245-kernel/prebuilts/dtb.img
BOARD_KERNEL_IMAGE := $(TARGET_KERNEL_PREBUILT)
BOARD_KERNEL_IMAGE_NAME := Image

# Ramdisk configuration
BOARD_RAMDISK_IMAGE := kernel/sony/pdx245-kernel/prebuilts/ramdisk.img

# Device Tree Blob (DTB) configuration
BOARD_DTB := kernel/sony/pdx245-kernel/prebuilts/dtb.img

# DTBO (Device Tree Blob Overlay)
BOARD_DTBO := kernel/sony/pdx245-kernel/prebuilts/dtbo.img

# Other prebuilt kernel-related images
BOARD_VENDOR_DLKM := kernel/sony/pdx245-kernel/prebuilts/vendor_dlkm.img
BOARD_SYSTEM_DLKM := kernel/sony/pdx245-kernel/prebuilts/system_dlkm.img

# Load kernel modules from vendor
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat vendor/sony/pdx245/proprietary/vendor/lib/modules/modules.load))

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += vendor/sony/pdx245/etc/selinux

# Product copy for kernel modules
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.ko,vendor/sony/pdx245/proprietary/vendor/lib/modules,$(TARGET_OUT_VENDOR)/lib/modules)
