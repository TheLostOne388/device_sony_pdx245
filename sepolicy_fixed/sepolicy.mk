# Device specific sepolicy fixes
# This file resolves issues with duplicate type declarations and missing types

# LineageOS types needed in system extension space
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/sony/pdx245/sepolicy_fixed/public
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/sony/pdx245/sepolicy_fixed/private

# Device-specific vendor policies
BOARD_VENDOR_SEPOLICY_DIRS += device/sony/pdx245/sepolicy_fixed/vendor

# Type mappings needed for compatibility
# These are redundant as they are also in BoardConfig.mk
#BOARD_SEPOLICY_M4DEFS += \
#    sysfs_battery_supply=vendor_sysfs_battery_supply \
#    sysfs_graphics=vendor_sysfs_graphics \
#    sysfs_usb_supply=vendor_sysfs_usb_supply \
#    display_vendor_data_file=vendor_display_vendor_data_file \
#    hal_gnss_qti=vendor_hal_gnss_qti \
#    hal_keymaster_qti_exec=vendor_hal_keymaster_qti_exec \
#    hal_perf_default=vendor_hal_perf_default \
#    location_domain=vendor_location \
#    persist_block_device=vendor_persist_block_device \
#    qdisplay_service=vendor_qdisplay_service 