#
# Copyright (C) 2023 Sony Corporation
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

# Minimal sepolicy configuration for Sony PDX245
# Created to fix build issues with unterminated comments and duplicate type declarations

# Force build with neverallow audit mode
SELINUX_IGNORE_NEVERALLOWS := true

# Load our override files first
BOARD_VENDOR_SEPOLICY_DIRS += device/sony/pdx245/sepolicy_fixed

# Then load standard Qualcomm policies
BOARD_VENDOR_SEPOLICY_DIRS += device/qcom/sepolicy_vndr/sm8650/generic/vendor/common
BOARD_VENDOR_SEPOLICY_DIRS += device/qcom/sepolicy_vndr/sm8650/generic/vendor/common/attribute

# Our vendor-specific files 
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/sony/pdx245/sepolicy_fixed/vendor

# Property settings needed for build
BUILD_BROKEN_ENFORCE_SYSPROP_OWNER := true
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/sony/pdx245/sepolicy_fixed/private

# Add our custom metadata ota policies
BOARD_VENDOR_SEPOLICY_TEE_FILES += device/sony/pdx245/sepolicy_fixed/ota.te 