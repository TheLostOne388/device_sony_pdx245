#
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

#
# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter pdx245,$(TARGET_DEVICE)),)
  subdir_makefiles=$(call first-makefiles-under,$(LOCAL_PATH))
  $(foreach mk,$(subdir_makefiles),$(info including $(mk) ...)$(eval include $(mk)))
endif

# Android.mk for device/sony/pdx245

# Include prebuilt kernel in the build
include $(CLEAR_VARS)
LOCAL_MODULE := kernel
LOCAL_SRC_FILES := kernel/sony/pdx245-kernel/prebuilts/Image
LOCAL_MODULE_PATH := $(TARGET_OUT_KERNEL)
LOCAL_MODULE_TAGS := optional
LOCAL_CERTIFICATE := platform
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_INSTALLER_SUFFIX)
include $(BUILD_PREBUILT)

# Prebuilt Ramdisk
include $(CLEAR_VARS)
LOCAL_MODULE := ramdisk
LOCAL_SRC_FILES := kernel/sony/pdx245-kernel/prebuilts/ramdisk
LOCAL_MODULE_PATH := $(TARGET_OUT_RAMDISK)
LOCAL_MODULE_TAGS := optional
LOCAL_CERTIFICATE := platform
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_INSTALLER_SUFFIX)
include $(BUILD_PREBUILT)

# Device Tree Blob (DTB)
include $(CLEAR_VARS)
LOCAL_MODULE := dtb
LOCAL_SRC_FILES := kernel/sony/pdx245-kernel/prebuilts/dtb.img
LOCAL_MODULE_PATH := $(TARGET_OUT_DTB)
LOCAL_MODULE_TAGS := optional
LOCAL_CERTIFICATE := platform
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_INSTALLER_SUFFIX)
include $(BUILD_PREBUILT)

# Device Tree Blob Overlay (DTBO)
include $(CLEAR_VARS)
LOCAL_MODULE := dtbo
LOCAL_SRC_FILES := kernel/sony/pdx245-kernel/prebuilts/dtbo.img
LOCAL_MODULE_PATH := $(TARGET_OUT_DTBO)
LOCAL_MODULE_TAGS := optional
LOCAL_CERTIFICATE := platform
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_INSTALLER_SUFFIX)
include $(BUILD_PREBUILT)

# Vendor DLKM
include $(CLEAR_VARS)
LOCAL_MODULE := vendor_dlkm
LOCAL_SRC_FILES := kernel/sony/pdx245-kernel/prebuilts/vendor_dlkm.img
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR_DLKM)
LOCAL_MODULE_TAGS := optional
LOCAL_CERTIFICATE := platform
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_INSTALLER_SUFFIX)
include $(BUILD_PREBUILT)

# System DLKM
include $(CLEAR_VARS)
LOCAL_MODULE := system_dlkm
LOCAL_SRC_FILES := kernel/sony/pdx245-kernel/prebuilts/system_dlkm.img
LOCAL_MODULE_PATH := $(TARGET_OUT_SYSTEM_DLKM)
LOCAL_MODULE_TAGS := optional
LOCAL_CERTIFICATE := platform
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_INSTALLER_SUFFIX)
include $(BUILD_PREBUILT)
