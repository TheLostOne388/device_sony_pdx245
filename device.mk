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
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

BOARD_SEPARATE_VENDOR := true

# Inherit from sony sm8650-common
$(call inherit-product, device/sony/sm8650-common/common.mk)

$(call inherit-product, hardware/qcom-caf/sm8650/wifi/legacy/qcwcn/wpa_supplicant_8_lib/Android.mk)

# Boot animation
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1440

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.manager@1.0

# Overlays
PRODUCT_PACKAGES += \
    SonyPDX245SystemUIRes \
    SonyPDX245NfcNciRes \
    SonyPDX245FrameworksRes

DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/sony \
    vendor/sony \
    vendor/sony/pdx245 \
    vendor/sony/sm8650-common \
    hardware/qcom-caf/sm8650/audio \
    hardware/qcom-caf/sm8650/display \
    hardware/qcom-caf/sm8650/media \
    hardware/qcom-caf/sm8650/wifi

# Inherit from vendor blobs
$(call inherit-product, vendor/sony/pdx245/pdx245-vendor.mk)

# Prebuilt kernel files
PRODUCT_COPY_FILES += \
    kernel/sony/pdx245-kernel/prebuilts/Image:kernel \
    kernel/sony/pdx245-kernel/prebuilts/dtb.img:dtb.img \
    kernel/sony/pdx245-kernel/prebuilts/dtbo.img:$(TARGET_COPY_OUT_VENDOR)/dtbo.img \
    kernel/sony/pdx245-kernel/prebuilts/system_dlkm.img:$(TARGET_COPY_OUT_SYSTEM_DLKM)/system_dlkm.img \
    kernel/sony/pdx245-kernel/prebuilts/vendor_dlkm.img:$(TARGET_COPY_OUT_VENDOR_DLKM)/vendor_dlkm.img