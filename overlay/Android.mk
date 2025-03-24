# Copyright (C) 2023 The LineageOS Project
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

LOCAL_PATH := $(call my-dir)

# This module creates a symbolic link to our HAL interface definitions
# This ensures that VINTF can find the interface definitions for manifest validation
# while still using Sony's implementation libraries
include $(CLEAR_VARS)
LOCAL_MODULE := vintf_hal_interfaces_overlay
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT)/hardware/interfaces
LOCAL_REQUIRED_MODULES := device_pdx245_interfaces

include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := device_pdx245_interfaces
LOCAL_MODULE_TAGS := optional

include $(BUILD_PHONY_PACKAGE) 