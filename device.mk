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


# Device identification
PRODUCT_DEVICE := pdx245
PRODUCT_NAME := lineage_pdx245
PRODUCT_MODEL := Sony Xperia XQ-EC72
PRODUCT_BRAND := Sony
PRODUCT_MANUFACTURER := Sony

# Inherit from sony sm8650-common
$(call inherit-product, device/sony/sm8650-common/common.mk)

$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Include Sony hardware interfaces
$(call inherit-product-if-exists, hardware/sony/Android.mk)

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

# Boot Control (Recovery)
PRODUCT_PACKAGES += \
    android.hardware.boot-service.qti.recovery

# Recovery configuration
PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/recovery/init.recovery.qcom.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.qcom.rc \
#    $(LOCAL_PATH)/recovery/android.hardware.boot-service.qti.recovery.rc:$(TARGET_COPY_OUT_RECOVERY)/root/android.hardware.boot-service.qti.recovery.rc \
    $(LOCAL_PATH)/configs/component-overrides.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/component-overrides.xml \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom

# Minimal Hybrid Recovery Configuration
$(call inherit-product-if-exists, $(LOCAL_PATH)/recovery/minimal_recovery.mk)

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
    vendor/sony/pdx245/sensors \
    device/sony/pdx245/vintf/interfaces \
    $(LOCAL_PATH)/interfaces/stubs

# Prebuilt kernel files
PRODUCT_COPY_FILES += \
    kernel/sony/pdx245/prebuilts/Image:kernel \
    kernel/sony/pdx245/prebuilts/dtb.img:dtb.img \
    kernel/sony/pdx245/prebuilts/dtbo.img:$(TARGET_COPY_OUT_VENDOR)/dtbo.img \
    kernel/sony/pdx245/prebuilts/system_dlkm.img:$(TARGET_COPY_OUT_SYSTEM_DLKM)/system_dlkm.img \
    kernel/sony/pdx245/prebuilts/vendor_dlkm.img:$(TARGET_COPY_OUT_VENDOR_DLKM)/vendor_dlkm.img

PRODUCT_VENDOR_KERNEL_HEADERS += kernel/sony/pdx245/prebuilts/kernel-headers

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

# Additional HAL interfaces needed for build
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0 \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service \
    android.hardware.nfc@1.0 \
    android.hardware.nfc@1.1 \
    android.hardware.nfc@1.2 \
    android.hardware.secure_element@1.0 \
    android.hardware.secure_element@1.1 \
    android.hardware.secure_element@1.2

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
    ro.boot.product.vendor.sku=pdx245 \
    ro.boot.product.hardware.sku=pdx245 \
    ro.vendor.kernel.version=6.1.43

# Sony VINTF compatibility matrix
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += hardware/sony/vintf/device_framework_matrix.xml

# VINTF paths and configuration
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.vintf.manifest.path=/vendor/etc/vintf/manifest.xml \
    ro.vendor.vintf.version=1.0

# Include FCM level configuration
include $(LOCAL_PATH)/fcm_level.mk

# Set shipping API level to match Android 14
PRODUCT_SHIPPING_API_LEVEL := 34

# Enable VINTF enforcement
PRODUCT_ENFORCE_VINTF_MANIFEST := true
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := true

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_PACKAGES += \
    fastbootd

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
    vendor.qti.hardware.display.config-V1-ndk.vendor \
    com.qualcomm.qti.dpm.api@1.0.vendor \
    com.qualcomm.qti.imscmservice@2.2.vendor \
    vendor.qti.hardware.display.config-V2-ndk.vendor \
    vendor.qti.hardware.display.config-V3-ndk.vendor \
    vendor.qti.hardware.display.config-V4-ndk.vendor \
    vendor.qti.hardware.display.config-V5-ndk.vendor \
    vendor.qti.hardware.display.config-V6-ndk.vendor \
    vendor.qti.hardware.display.config-V7-ndk.vendor \
    vendor.qti.hardware.display.config-V8-ndk.vendor \
    vendor.qti.hardware.display.config-V9-ndk.vendor \
    vendor.qti.hardware.display.config-V10-ndk.vendor \
    vendor.qti.hardware.display.config-V11-ndk.vendor \
    vendor.qti.hardware.display.config-V12-ndk.vendor \
    vendor.qti.hardware.display.color-V1-ndk.vendor \
    vendor.qti.hardware.display.composer3-V1-ndk.vendor \
    vendor.qti.hardware.display.postproc-V1-ndk.vendor \
    libdisplayconfig.qti.vendor \
    libgralloc.qti.vendor \
    libqdMetaData.vendor \
    vendor.qti.hardware.bluetooth.audio-V1-ndk.vendor \
    vendor.qti.hardware.btconfigstore@1.0.vendor \
    vendor.qti.hardware.btconfigstore@2.0.vendor \
    vendor.qti.hardware.camera.aon-V1-ndk.vendor \
    vendor.qti.hardware.camera.offlinecamera-V1-ndk.vendor \
    vendor.qti.hardware.camera.offlinecamera-V2-ndk.vendor \
    vendor.qti.hardware.camera.postproc@1.0.vendor \
    libvndfwk_detect_jni.qti_vendor.vendor \
    libwfdaac_vendor.vendor \
    vendor.qti.hardware.capabilityconfigstore@1.0.vendor \
    vendor.qti.hardware.perf@2.0.vendor \
    vendor.qti.hardware.perf@2.1.vendor \
    vendor.qti.hardware.perf@2.2.vendor \
    vendor.qti.hardware.perf@2.3.vendor \
    vendor.qti.hardware.qspa-V1-ndk.vendor \
    vendor.qti.hardware.servicetracker@1.0.vendor \
    vendor.qti.hardware.servicetracker@1.1.vendor \
    vendor.qti.hardware.servicetrackeraidl-V1-ndk.vendor \
    vendor.qti.hardware.systemhelper@1.0.vendor \
    vendor.qti.hardware.systemhelperaidl-V1-ndk.vendor \
    vendor.qti.hardware.wifi.wifilearner@1.0.vendor \
    vendor.qti.ims.callinfo@1.0.vendor \
    vendor.qti.ims.factory@1.1.vendor \
    vendor.qti.spu@1.1.vendor \
    vendor.qti.hardware.spu@1.0.vendor \
    vendor.nxp.nxpnfc_aidl.vendor

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

DEVICE_PACKAGE_OVERLAYS += device/sony/pdx245/overlay

# Inherit from vendor blobs
$(call inherit-product, vendor/sony/pdx245/pdx245-vendor.mk)
$(call inherit-product, vendor/sony/sm8650-common/sm8650-common-vendor.mk)

# Include VINTF stub interfaces to satisfy build
$(call inherit-product, device/sony/pdx245/pdx245-vintf.mk)


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
    vendor.semc.hardware.charger@1.2-service

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

PRODUCT_PACKAGES += \
    android.hidl.base@1.0

# A/B related packages for OTA update
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-impl.recovery \
    android.hardware.boot@1.0-service \
    bootctrl.$(TARGET_BOARD_PLATFORM).recovery \
    bootctrl.$(TARGET_BOARD_PLATFORM) \
    otapreopt_script

# A/B OTA dexopt update_engine hookup
PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# A/B Boot control HAL - use compatible version
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl-qti \
    android.hardware.boot@1.0-impl-qti.recovery \
    android.hardware.boot@1.0-service

# A/B specific properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.ab_update=true \
#    ro.virtual_ab.enabled=true

# $(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Additional variables to handle duplicate modules
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := false
PRODUCT_ENFORCE_RRO_TARGETS := 
RELAX_USES_LIBRARY_CHECK := true
ALLOW_MISSING_DEPENDENCIES := true

# Override to ensure prebuilt libar-pal is used instead of source from hardware/qcom-caf/sm8650
PRODUCT_PACKAGES += libar-pal

# This makefile is included from BoardConfig.mk to add device-specific packages.

# Ensure the vendor_ramdisk is built and available for our custom vendor_boot module.
PRODUCT_PACKAGES += vendor_ramdisk

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
# $(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Use sepolicy version matching vendor manifest
BOARD_SEPOLICY_VERS := 34.0

# Kernel version
ro.vendor.kernel.version=6.1.43

# Enforce VINTF
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.product.hardware.sku=pdx245 \
    ro.vendor.kernel.version=6.1.43

# Sony VINTF compatibility matrix
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += hardware/sony/vintf/device_framework_matrix.xml

# Add FCM version properties for Level 8 format
PRODUCT_PROPERTY_OVERRIDES += \
    ro.board.api_level=34 \
    ro.board.first_api_level=34 \
    ro.vendor.fcm.version=8

# Enable ignoring VINTF version mismatches for vendor components
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.api_level=34 \
    ro.build.version.known_codenames=REL

# Enforce VINTF requirements
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# Include Sony VINTF compatibility matrix
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += hardware/sony/vintf/device_framework_matrix.xml

# Vendor VINTF manifests
DEVICE_MANIFEST_SKUS := pdx245
DEVICE_MANIFEST_PDX245_FILES := \
    $(LOCAL_PATH)/vintf/manifest.xml \
    vendor/sony/sm8650-common/proprietary/vendor/etc/vintf/manifest/manifest_pineapple.xml \
    vendor/sony/pdx245/proprietary/vendor/etc/vintf/manifest/fingerprint-rbs.xml \
    vendor/sony/pdx245/proprietary/vendor/etc/vintf/manifest/vendor.semc.hardware.aidlcharge-somc.xml \
    vendor/sony/pdx245/proprietary/vendor/etc/vintf/manifest/vendor.semc.hardware.extlight-somc.xml \
    vendor/sony/pdx245/proprietary/vendor/etc/vintf/manifest/vendor.somc.hardware.aidlmiscta-somc.xml \
    vendor/sony/pdx245/proprietary/vendor/etc/vintf/manifest/vendor.somc.hardware.aidlsensor-somc.xml \
    vendor/sony/pdx245/proprietary/vendor/etc/vintf/manifest/vendor.somc.hardware.aidlsuperstamina.xml \
    vendor/sony/pdx245/proprietary/vendor/etc/vintf/manifest/vendor.somc.hardware.camera.provider.manifest.xml \
    vendor/sony/pdx245/proprietary/vendor/etc/vintf/manifest/vendor.somc.hardware.perfagent-somc.xml \
    vendor/sony/pdx245/proprietary/vendor/etc/vintf/manifest/vendor.somc.hardware.radio.xml

# Stub Interface Packages for VINTF Check
PRODUCT_PACKAGES += \
    android.hardware.fingerprint@2.3 \
    com.qualcomm.qti.uceservice@2.3 \
    vendor.qti.hardware.ListenSoundModel@1.0-impl \
    vendor.qti.hardware.bluetooth_sar@1.1-impl \
    vendor.qti.hardware.cacert@1.0-impl \
    vendor.qti.hardware.fm@1.0-impl \
    vendor.qti.hardware.secureprocessor.device@1.0-impl \
    vendor.qti.hardware.spu \
    vendor.qti.hardware.wifi.wifilearner@1.0-impl \
    vendor.qti.ims.callinfo@1.0-impl \
    vendor.qti.ims.factory@1.0-impl \
    vendor.qti.ims.factory@1.1-impl \
    vendor.qti.spu@1.0-impl \
    vendor.qti.spu@1.1-impl \
    vendor.semc.hardware.charger@1.2-impl \
    vendor.semc.hardware.mmwavedirection@1.1-impl \
    vendor.somc.hardware.radio@1.0-impl

# Include custom overrides for prebuilt images
# -include $(DEVICE_PATH)/custom_image_overrides.mk # Reverted

# Additional properties if needed for specific features
# ...






