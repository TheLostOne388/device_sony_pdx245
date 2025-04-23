# Include all VINTF-related packages for PDX245

# Sony hardware interfaces from LineageOS
PRODUCT_PACKAGES += \
    vendor.egistec.hardware.fingerprint@4.0 \
    vendor.egistec.hardware.fingerprint@4.0-service \
    vendor.semc.hardware.charger@1.0-1 \
    vendor.semc.hardware.display@2.2-5 \
    vendor.semc.system.idd@1.0-1 \
    vendor.semc.system.idd@1.1 \
    vendor.somc.hardware.aidlmiscta-service.somc \
    vendor.somc.hardware.miscta@1.0 \
    vendor.somc.hardware.nfc@1.0 \
    vendor.somc.hardware.radio@1.0 \
    vendor.somc.hardware.security.secd@1.1

# QTI interfaces
PRODUCT_PACKAGES += \
    vendor.qcom.opensource.btconfigstore \
    vendor.qcom.opensource.bluetooth_audio \
    vendor.qcom.opensource.capabilityconfigstore \
    vendor.qcom.opensource.display \
    vendor.qcom.opensource.perf \
    vendor.qcom.opensource.systemhelper \
    vendor.qcom.opensource.wifi

# Sony stubs (to be generated)
PRODUCT_PACKAGES += \
    vendor.semc.hardware.aidlcharger_stub \
    vendor.semc.hardware.aidldisplay_stub \
    vendor.semc.hardware.aidlthermal_stub \
    vendor.semc.hardware.extlight_stub \
    vendor.semc.hardware.spc_stub \
    vendor.semc.system.idd.aidl_stub \
    vendor.somc.hardware.aidlifaa_stub \
    vendor.somc.hardware.aidlmiscta_stub \
    vendor.somc.hardware.aidlnfc_stub \
    vendor.somc.hardware.aidlsensor_stub \
    vendor.somc.hardware.aidlsuperstamina_stub \
    vendor.somc.hardware.aidlwifidriver_stub \
    vendor.somc.hardware.camera.provider_stub \
    vendor.somc.hardware.perfagent_stub \
    vendor.somc.hardware.radio.aidl_stub \
    vendor.somc.hardware.security.aidlsecd_stub \
    vendor.somc.hardware.videoeffect_stub \
    vendor.somc.hardware.wifi.idd_stub \
    vendor.hardware.biometrics.fingerprintRbs_stub

# HIDL stubs (Sony-specific)
PRODUCT_PACKAGES += \
    vendor.semc.hardware.charger.aidl_stub \
    vendor.semc.hardware.mmwavedirection.aidl_stub

# Skip VINTF check during development (optional)
# PRODUCT_PACKAGES += \
#    android.hardware.fingerprint.aidl_stub

# Disable VINTF checking for development
#PRODUCT_VINTF_FRAGMENT_DISCARD_SYSTEMEXT_MANIFEST_FRAGMENTS := true
#PRODUCT_VINTF_FRAGMENT_DISCARD_VENDOR_MANIFEST_FRAGMENTS := true
#PRODUCT_VINTF_FRAGMENT_DISCARD_PRODUCT_MANIFEST_FRAGMENTS := true

# We need these stubs
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    device/sony/pdx245/vintf/device_framework_compatibility_matrix.xml

# Include this in your device.mk
# $(call inherit-product, device/sony/pdx245/pdx245-vintf.mk) 