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
#

# Inherit from sony sm8650-common
-include device/sony/sm8650-common/BoardConfigCommon.mk

DEVICE_PATH := device/sony/pdx245

# Display
TARGET_SCREEN_DENSITY := 420

# Props
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# inherit from the proprietary version
-include vendor/sony/pdx245/BoardConfigVendor.mk

# Kernel Configuration
TARGET_KERNEL_PREBUILT := $(LOCAL_PATH)/prebuilts/Image
TARGET_KERNEL_USE_PREBUILT := true
BOARD_PREBUILT_DTBIMAGE := $(LOCAL_PATH)/prebuilts/dtb.img
BOARD_KERNEL_IMAGE := $(TARGET_KERNEL_PREBUILT)
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_NO_KERNEL_OVERRIDE := true

# Load kernel modules from vendor/sony/pdx245/proprietary
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat vendor/sony/pdx245/proprietary/vendor/lib/modules/modules.load))

# Blocklist for vendor kernel modules (if applicable)
# BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(COMMON_PATH)/modules.blocklist

# Load kernel modules from vendor boot (vendor_boot)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(COMMON_PATH)/modules.load.vendor_boot))

# Load system kernel modules from the system_dlkm configuration
SYSTEM_KERNEL_MODULES := $(strip $(shell cat $(COMMON_PATH)/modules.include.system_dlkm))

# Optionally, uncomment if you need to use boot kernel modules from recovery or vendor ramdisk
BOOT_KERNEL_MODULES := $(strip $(shell cat $(COMMON_PATH)/modules.load.recovery $(COMMON_PATH)/modules.include.vendor_ramdisk))

# If you had a blocklist, this would apply it to the vendor ramdisk modules
# BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE)


# Kernel modules
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(LOCAL_PATH)/modules.load.vendor_boot))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(LOCAL_PATH)/vendor_ramdisk/modules.blocklist

BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(LOCAL_PATH)/vendor_ramdisk/modules.load.recovery))

#PRODUCT_COPY_FILES += \
#    $(call find-copy-subdir-files,*,$(KERNEL_PATH)/vendor_dlkm/,$(TARGET_COPY_OUT_VENDOR_DLKM)/lib/modules) \
#    $(call find-copy-subdir-files,*,$(KERNEL_PATH)/vendor_ramdisk/,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules) \
#    $(call find-copy-subdir-files,*,$(KERNEL_PATH)/system_dlkm/,$(TARGET_COPY_OUT_SYSTEM_DLKM)/lib/modules/6.1.25-android14-11-g9f6af9a6c2cc-ab11205628)


# Ramdisk configuration
BOARD_RAMDISK_IMAGE := $(LOCAL_PATH)/prebuilts/ramdisk

# Device Tree Blob (DTB) configuration
BOARD_DTB := $(LOCAL_PATH)/prebuilts/dtb.img

# DTBO (Device Tree Blob Overlay)
BOARD_DTBO := $(LOCAL_PATH)/prebuilts/dtbo.img

# Other prebuilt kernel-related images (if applicable)
BOARD_VENDOR_DLKM := $(LOCAL_PATH)/prebuilts/vendor_dlkm.img
BOARD_SYSTEM_DLKM := $(LOCAL_PATH)/prebuilts/system_dlkm.img

BOARD_VENDOR_SEPOLICY_DIRS += vendor/sony/pdx245/etc/selinux

# Copy Kernel Modules
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.ko,vendor/sony/pdx245/proprietary/vendor/lib/modules,$(TARGET_COPY_OUT_VENDOR)/lib/modules)