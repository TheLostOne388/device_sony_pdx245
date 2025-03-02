# This makefile is included from device.mk to set the FCM level for VINTF

# Set FCM level in the device properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.first_api_level=33 \
    ro.board.first.api.level=33

# Set the shipping API level
PRODUCT_SHIPPING_API_LEVEL := 33

# Set the framework compatibility matrix version
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.product.vndk.version=33 \
    ro.vendor.vintf.level=15

# Set the FCM level for the build system
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.api_level=33 \
    ro.vendor.shipping_api_level=33

# Define the FCM level explicitly in properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.fcm.level=15