# Include QTI sepolicy first
include device/qcom/sepolicy_vndr/sm8550/SEPolicy.mk
include hardware/sony/sepolicy/qti/SEPolicy.mk

BOARD_VENDOR_SEPOLICY_DIRS := \
    system/sepolicy/vendor \
    $(DEVICE_PATH)/sepolicy/vendor/attributes \
    device/qcom/sepolicy_vndr/sm8550/generic/vendor/common \
    device/qcom/sepolicy_vndr/sm8550/generic/vendor/pineapple \
    device/qcom/sepolicy_vndr/sm8550/qva/vendor/common \
    device/qcom/sepolicy_vndr/sm8550/qva/vendor/pineapple \
    $(DEVICE_PATH)/sepolicy/vendor \
    vendor/sony/pdx245/proprietary/vendor/etc/selinux \
    device/lineage/sepolicy/qcom/vendor

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/lineage/sepolicy/common/private \
    device/lineage/sepolicy/qcom/dynamic \
    device/lineage/sepolicy/qcom/private \
    $(DEVICE_PATH)/sepolicy/private

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += \
    device/lineage/sepolicy/common/public \
    device/sony/pdx245/sepolicy/public

PRODUCT_PUBLIC_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy/public

# Define the mapping
BOARD_SEPOLICY_M4DEFS += \
    vendor_sysfs_graphics=sysfs_graphics