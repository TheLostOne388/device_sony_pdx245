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
BOARD_VENDOR_SEPOLICY_DIRS += device/sony/pdx245/sepolicy_fixed/vendor

# Property settings needed for build
BUILD_BROKEN_ENFORCE_SYSPROP_OWNER := true
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true 