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
DEVICE_MANIFEST_FILE += device/sony/sm8650-common/configs/manifest_graphics.xml

# Display
TARGET_SCREEN_DENSITY := 420

# Props
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Kernel Configuration
KERNEL_PATH := kernel/sony/pdx245-kernel/prebuilts

# Basic kernel config
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_DTB_OFFSET := 0x01f00000

# Kernel cmdline inheritance and additions
BOARD_KERNEL_CMDLINE := $(BOARD_KERNEL_CMDLINE) androidboot.selinux=permissive

# Boot image configuration
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)

# Prebuilt kernel (override common config)
TARGET_KERNEL_SOURCE :=
TARGET_KERNEL_CONFIG :=
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/Image
BOARD_KERNEL_IMAGE_NAME := Image

# DTB/DTBO
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE := $(KERNEL_PATH)/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img
BOARD_MKBOOTIMG_ARGS += --dtb $(KERNEL_PATH)/dtb.img

# DLKM
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/*.ko)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat vendor/sony/pdx245/proprietary/vendor/lib/modules/modules.load))

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += vendor/sony/pdx245/etc/selinux

# Inherit from the proprietary version
-include vendor/sony/pdx245/BoardConfigVendor.mk