# This makefile is included from device.mk to set the FCM level for VINTF
# Set FCM level in the device properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.first_api_level=34 \
    ro.board.first.api.level=34

# Set the shipping API level
PRODUCT_SHIPPING_API_LEVEL := 34

# Set the framework compatibility matrix version
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.product.vndk.version=34 \
    ro.vendor.vintf.level=8

# Set the FCM level for the build system
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.api_level=34 \
    ro.vendor.shipping_api_level=34

# Set Android 15 date-based SEPolicy version
PRODUCT_PROPERTY_OVERRIDES += \
    ro.system.build.sepolicy.version=202410 \
    ro.system.build.sepolicy.vers_api=34