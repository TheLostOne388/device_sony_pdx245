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
LINEAGE_BUILD := true

LOCAL_PATH := $(call my-dir)

# Prevent AOSP APN list inclusion
PRODUCT_NO_TELEPHONY := true

# Include the audio module from the Android.mk file
# include $(TOP)/hardware/qcom-caf/sm8650/audio/Android.mk

PRODUCT_SOONG_NAMESPACES += \
#    hardware/qcom-caf/sm8650/audio

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from device-specific configuration
$(call inherit-product, device/sony/pdx245/device.mk)

# Inherit from vendor configuration
$(call inherit-product, vendor/sony/pdx245/pdx245-vendor.mk)

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Include the prebuilt kernel
$(call inherit-product, device/sony/pdx245/kernel.mk)

IS_PHONE := true

PRODUCT_NAME := lineage_pdx245
PRODUCT_DEVICE := pdx245
PRODUCT_BRAND := Sony
PRODUCT_MODEL := XQ-EC72
PRODUCT_MANUFACTURER := Sony

TARGET_SUPPORTS_GOOGLE_RECORDER := true
TARGET_INCLUDE_STOCK_ARCORE := true
TARGET_INCLUDE_LIVE_WALLPAPERS := true
TARGET_SUPPORTS_QUICK_TAP := true
TARGET_SUPPORTS_CALL_RECORDING := true
TARGET_INCLUDE_CARRIER_SERVICES := true
TARGET_INCLUDE_CARRIER_SETTINGS := true
TARGET_SUPPORTS_GOOGLE_BATTERY := true
MAINLINE_INCLUDE_VIRT_MODULE := true
TARGET_FACE_UNLOCK_SUPPORTED := true


PRODUCT_SYSTEM_NAME := XQ-EC72
PRODUCT_SYSTEM_DEVICE := XQ-EC72

PRODUCT_GMS_CLIENTID_BASE := android-sonymobile

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=$(PRODUCT_SYSTEM_DEVICE) \
    TARGET_PRODUCT=$(PRODUCT_SYSTEM_NAME) \
    PRIVATE_BUILD_DESC="XQ-EC72-userdebug 15 69.1.A.2.78 069001A002007800522519484 release-keys"

BUILD_FINGERPRINT := Sony/XQ-EC72/XQ-EC72:15/69.1.A.2.78/069001A002007800522519484:user/release-keys
