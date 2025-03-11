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

# BOARD_SEPARATE_VENDOR moved to BoardConfig.mk

# Inherit from sony sm8650-common
$(call inherit-product, device/sony/sm8650-common/common.mk)

PRODUCT_TARGET_FCM_VERSION := 9

# Boot animation
TARGET_SCREEN_HEIGHT := 2330
TARGET_SCREEN_WIDTH := 1080

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# ODM files
PRODUCT_PACKAGES += \
    odm_files \
    media_profiles_V1_0_odm
	
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.manager@1.0

# Overlays
PRODUCT_PACKAGES += \
    SonyPDX245SystemUIRes \
    SonyPDX245NfcNciRes \
    SonyPDX245FrameworksRes \

DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

# Soong namespaces - Prioritize Sony modules
PRODUCT_SOONG_NAMESPACES += \
    vendor/sony \
    vendor/sony/pdx245 \
    vendor/sony/sm8650-common \
    $(LOCAL_PATH) \
    device/sony/pdx245/interfaces \
    hardware/sony \
    vendor/lineage \
    hardware/qcom-caf/sm8550/display \
    hardware/qcom-caf/sm8550/media \
    hardware/interfaces/media/omx/1.0 \
    hardware/interfaces/media/c2/1.0 \
    hardware/interfaces/bluetooth/audio \
    vendor/qcom/opensource/interfaces \
    kernel/sony/pdx245 \
    vendor/sony/pdx245/sensors

# Prebuilt kernel files
PRODUCT_COPY_FILES += \
    kernel/sony/pdx245/prebuilts/Image:kernel \
    kernel/sony/pdx245/prebuilts/dtb.img:dtb.img \
    kernel/sony/pdx245/prebuilts/dtbo.img:$(TARGET_COPY_OUT_VENDOR)/dtbo.img \
    kernel/sony/pdx245/prebuilts/system_dlkm.img:$(TARGET_COPY_OUT_SYSTEM_DLKM)/system_dlkm.img \
    kernel/sony/pdx245/prebuilts/vendor_dlkm.img:$(TARGET_COPY_OUT_VENDOR_DLKM)/vendor_dlkm.img 
	
# Override system_ext partition assignments
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/privapp-permissions-qti.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-qti.xml

# Ensure vendor variants are used
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.qti.sys.fw.bservice_enable=true \
    ro.vendor.qti.sys.fw.bservice_limit=5 \
    ro.vendor.qti.sys.fw.bservice_age=5000

# Media
PRODUCT_PACKAGES += \
    libavservices_minijail \
    libavservices_minijail.vendor \
    libcodec2_hidl@1.0.vendor \
    libcodec2_vndk.vendor \
    libmedia_omx \
    libstagefright_omx \
    libstagefright_foundation \
    libstagefright_softomx.vendor

# OMX
PRODUCT_PACKAGES += \
    libOmxCore \
    libOmxVdec \
    libOmxVenc \
    libstagefrighthw

# Media dependencies
PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.0 \
    android.hardware.media.c2@1.0-service \
    android.hardware.graphics.bufferqueue@1.0 \
    android.hardware.graphics.bufferqueue@2.0 \
    android.hardware.graphics.common@1.0 \
    android.hardware.graphics.common@1.1 \
    android.hardware.graphics.common@1.2 \
    android.hardware.graphics.mapper@3.0 \
    android.hardware.graphics.mapper@4.0

# Already included in Soong namespaces above
	
# DRM HIDL
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.0

# If needed, also add:
PRODUCT_PACKAGES += \
    android.hardware.drm@1.1 \
    android.hardware.drm@1.2 \
    android.hardware.drm@1.3 \
    android.hardware.drm@1.4

# Bluetooth Audio HIDL
PRODUCT_PACKAGES += \
    android.hardware.bluetooth.audio@2.0 \
    android.hardware.bluetooth.audio@2.0-impl \
    android.hardware.bluetooth.audio@2.1 \
    android.hardware.bluetooth.audio@2.1-impl

# Bluetooth Audio (System) - Needed for A2DP
PRODUCT_PACKAGES += \
    audio.bluetooth.default \
    android.hardware.bluetooth.a2dp@1.0 \
    android.hardware.bluetooth.a2dp@1.0-impl

# Qualcomm Bluetooth Audio
PRODUCT_PACKAGES += \
    vendor.qti.hardware.bluetooth_audio@2.0 \
    vendor.qti.hardware.bluetooth_audio@2.1 \
    vendor.qti.hardware.bluetooth_audio@2.1-impl

# Bluetooth Dependencies
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0 \
    android.hardware.bluetooth@1.1 \
    vendor.qti.hardware.btconfigstore@1.0 \
    vendor.qti.hardware.btconfigstore@2.0

PRODUCT_PACKAGES += libOpenCL

PRODUCT_VENDOR_KERNEL_HEADERS += device/sony/pdx245/kernel-headers

$(shell bash $(LOCAL_PATH)/patches/fix_init_rc.sh)

# Remove any wifi-related packages that might conflict
PRODUCT_PACKAGES_REMOVE += \
    android.hardware.wifi@1.0-service \
    android.hardware.wifi.hostapd@1.0 \
    android.hardware.wifi.hostapd@1.1 \
    android.hardware.wifi.hostapd@1.2 \
    android.hardware.wifi.hostapd@1.3

# VINTF properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.product.vendor.sku=default \
    ro.boot.product.hardware.sku=default \
    ro.vendor.kernel.version=6.1.43

# VINTF paths
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.vintf.manifest.path=/vendor/etc/vintf/manifest.xml \
    ro.vendor.vintf.version=1.0

PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Wifi
PRODUCT_PACKAGES += \
    libwpa_client \
    wpa_supplicant \
    wpa_supplicant.conf \
    hostapd

PRODUCT_PACKAGES += \
    vendor.qti.hardware.radio.ims@1.0 \
    vendor.qti.hardware.radio.qtiradio@2.0 \

PRODUCT_PACKAGES += \
    android.hardware.radio@1.3 \
    android.hardware.radio@1.4 \
    vendor.qti.hardware.bluetooth_sar@1.0 \
    vendor.nxp.hardware.nfc@1.0 \
    vendor.nxp.hardware.nfc@1.1 

# Device-specific HIDL interfaces
PRODUCT_PACKAGES += \
    vendor.qti.hardware.bluetooth_sar@1.0 \
    vendor.qti.hardware.bluetooth_sar@1.1 \
    vendor.nxp.nxpnfc

# NFC packages (keep AIDL-compatible ones)
PRODUCT_PACKAGES += \
    vendor.nxp.nxpnfc@2.0

# Additional QTI HALs (remove deprecated HIDL where stock uses AIDL)
PRODUCT_PACKAGES += \
    vendor.qti.hardware.data.connection@1.0 \
    vendor.qti.hardware.data.connection@1.1 \
    vendor.qti.hardware.data.iwlan@1.0 \
    vendor.qti.hardware.data.iwlan@1.1 \
    vendor.qti.hardware.display.color@1.0 \
    vendor.qti.hardware.display.composer3 \
    vendor.qti.hardware.display.config \
    vendor.qti.hardware.display.demura \
    vendor.qti.hardware.display.postproc \
    vendor.qti.hardware.dpmservice@1.0 \
    vendor.qti.hardware.dpmservice@1.1 \
    vendor.qti.hardware.radio.ims@1.0-2 \
    vendor.qti.hardware.spu@1.0-2

# Missing Core HALs
PRODUCT_PACKAGES += \
    android.hardware.power-service.sony-libperfmgr \
    android.hardware.light-service.sony \
    android.hardware.usb@1.3-service.sony \
    android.hardware.vibrator-service.sony

# Force vendor variants if needed
PRODUCT_PACKAGES += \
    vendor.qti.hardware.data.connection@1.1.vendor \
    vendor.qti.hardware.data.iwlan@1.0.vendor \
    vendor.qti.hardware.display.config-V1-ndk.vendor

# VINTF Manifest Configuration
DEVICE_MANIFEST_FILE := vendor/sony/sm8650-common/proprietary/vendor/etc/vintf/manifest/manifest_pineapple.xml
DEVICE_MANIFEST_SKUS := pdx245
DEVICE_MANIFEST_PDX245_FILES := \
    vendor/sony/sm8650-common/proprietary/vendor/etc/vintf/manifest/manifest_pineapple.xml \
    vendor/sony/pdx245/proprietary/vendor/etc/vintf/manifest/android.hardware.boot.xml

PRODUCT_PACKAGES += \
    android.hardware.sensors-service.pdx245 \
    android.hardware.sensors-service.pdx245.xml \
    android.system.wifi.keystore@1.0-service \
    android.system.wifi.keystore.xml

PRODUCT_PACKAGES -= \
    android.hardware.sensors@2.1-multihal \
    android.hardware.sensors@2.1-service.multihal \
    android.hardware.sensors@2.0-multihal.xml \
    android.hardware.sensors@2.0-service.multihal \
    android.hardware.sensors@2.0-multihal-sony.xml

DEVICE_MANIFEST_FILE += vendor/sony/pdx245/proprietary/vendor/etc/vintf/manifest/android.system.wifi.keystore.xml

# Optional: Include manifest if not using vintf_fragments in Android.bp
DEVICE_MANIFEST_FILE += device/sony/pdx245/wifi_keystore/1.0/default/android.system.wifi.keystore.xml

# Include the wifi keystore manifest fragment
DEVICE_MANIFEST_FILE += device/sony/pdx245/wifi_keystore/1.0/default/android.system.wifi.keystore.xml
    
DEVICE_PACKAGE_OVERLAYS += device/sony/pdx245/overlay

# Device compatibility matrix
DEVICE_MATRIX_FILE := \
    vendor/sony/sm8650-common/proprietary/vendor/etc/vintf/compatibility_matrix.xml

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    vendor/sony/sm8650-common/proprietary/vendor/etc/vintf/device_framework_compatibility_matrix.xml

# Set shipping API level to match Android 15
PRODUCT_SHIPPING_API_LEVEL := 34

# Enable VINTF enforcement
PRODUCT_ENFORCE_VINTF_MANIFEST := true
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := true

# Inherit from vendor blobs
$(call inherit-product, vendor/sony/pdx245/pdx245-vendor.mk)
$(call inherit-product, vendor/sony/sm8650-common/sm8650-common-vendor.mk)

# Pakcages that conflict with LineageOS which we aim to override and use Sony's versions
PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.config-V1-ndk \
    vendor.qti.hardware.display.config-V2-ndk \
    vendor.qti.hardware.display.config-V3-ndk \
    vendor.qti.hardware.display.config-V4-ndk \
    vendor.qti.hardware.display.config-V5-ndk \
    vendor.qti.hardware.display.config-V6-ndk \
    vendor.qti.hardware.display.config-V7-ndk \
    vendor.qti.hardware.display.config-V8-ndk \
    vendor.qti.hardware.display.config-V9-ndk \
    vendor.qti.hardware.display.config-V10-ndk \
    vendor.qti.hardware.display.config-V11-ndk \
    vendor.qti.hardware.display.config-V12-ndk \
    vendor.qti.hardware.display.color-V1-ndk \
    vendor.qti.hardware.display.composer3-V1-ndk \
    vendor.qti.hardware.display.postproc-V1-ndk \
    libdisplayconfig.qti \
    libgralloc.qti \
    libqdMetaData \
    vendor.qti.hardware.bluetooth.audio-V1-ndk \
    vendor.qti.hardware.btconfigstore@1.0 \
    vendor.qti.hardware.btconfigstore@2.0 \
    vendor.qti.hardware.camera.aon-V1-ndk \
    vendor.qti.hardware.camera.offlinecamera-V1-ndk \
    vendor.qti.hardware.camera.offlinecamera-V2-ndk \
    vendor.qti.hardware.camera.postproc@1.0 \
    libvndfwk_detect_jni.qti_vendor \
    libwfdaac_vendor \
    vendor.qti.hardware.capabilityconfigstore@1.0 \
    vendor.qti.hardware.perf@2.0 \
    vendor.qti.hardware.perf@2.1 \
    vendor.qti.hardware.perf@2.2 \
    vendor.qti.hardware.perf@2.3 \
    vendor.qti.hardware.qspa-V1-ndk \
    vendor.qti.hardware.servicetracker@1.0 \
    vendor.qti.hardware.servicetracker@1.1 \
    vendor.qti.hardware.servicetrackeraidl-V1-ndk \
    vendor.qti.hardware.systemhelper@1.0 \
    vendor.qti.hardware.systemhelperaidl-V1-ndk

PRODUCT_PACKAGES += android.hidl.allocator@1.0-service

# Audio HAL
PRODUCT_PACKAGES += \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.effect@7.0-impl

# Bluetooth HAL
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.1-impl-qti \
    android.hardware.bluetooth.audio-impl-qti

# Sony AIDL HAL Services
PRODUCT_PACKAGES += \
    vendor.semc.hardware.aidlcharger-service.somc \
    vendor.semc.hardware.aidldisplay-service.somc \
    vendor.semc.hardware.aidlsecd-service \
    vendor.semc.hardware.extlight-service.somc \
    vendor.somc.hardware.aidlmiscta-service.somc \
    vendor.somc.hardware.aidlsuperstamina-service \
    vendor.somc.hardware.aidlwifidriver-service \
    vendor.somc.hardware.camera.provider@1.0-service \
    vendor.somc.hardware.wifi.idd-service

# Legacy HALs still needed
PRODUCT_PACKAGES += \
    vendor.semc.hardware.charger@1.2-service \
    vendor.semc.hardware.mmwavedirection@1.1-service

# Sony RC files
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/sony/pdx245/proprietary/vendor/etc/init/,$(TARGET_COPY_OUT_VENDOR)/etc/init/)

# Sony HALs
PRODUCT_PACKAGES += \
    vendor.semc.hardware.display@2.2-5 \
    vendor.semc.hardware.charger@1.0-1 \
    vendor.semc.system.idd@1.1 \
    vendor.somc.hardware.aidlmiscta-V1-ndk_platform

PRODUCT_PACKAGES += \
    bix.fingerprint.default \
    sound_trigger.primary.pineapple
   
# HIDL
PRODUCT_PACKAGES += \
    vendor.qti.hardware.pal@1.0 \
    vendor.qti.hardware.AGMIPC@1.0

# Audio HAL
PRODUCT_PACKAGES += \
    audio.primary.pineapple


