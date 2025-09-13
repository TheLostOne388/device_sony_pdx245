# Enable AVB but disable dm-verity for development (LineageOS standard)
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_MAKE_VBMETA_SYSTEM_IMAGE_ARGS += --flags 3
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# Use generated key for all AVB signing (matches stock algorithm/hash pattern)
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_ALGORITHM := SHA256_RSA4096

# Match stock vbmeta rollback settings (bumped +1 to avoid protection)
BOARD_AVB_ROLLBACK_INDEX := 1743465601
BOARD_AVB_ROLLBACK_INDEX_LOCATION := 0

# Boot partition - matches stock
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_BOOT_ROLLBACK_INDEX := 1743465601
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 3
BOARD_AVB_BOOT_ADD_HASH_FOOTER_ARGS += --prop com.android.build.boot.os_version:15 --prop com.android.build.boot.security_patch:2025-07-01

# Recovery - matches stock
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1743465601
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# vbmeta_system - matches stock (bumped from 1730419200) - temporarily disabled to fix build error
BOARD_AVB_VBMETA_SYSTEM := system system_dlkm system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 1743465601
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
BOARD_AVB_VBMETA_SYSTEM_ARGS += --prop com.android.build.vbmeta_system.os_version:15 --prop com.android.build.vbmeta_system.security_patch:2025-07-01

# init_boot - matches stock pattern
BOARD_AVB_INIT_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_INIT_BOOT_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX := 1743465601
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := 4

# vendor_boot - stock uses hash descriptor, but we'll chain it
BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_BOOT_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := 1743465601
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 6
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS += --prop com.android.build.vendor.os_version:15 --prop com.android.build.vendor.security_patch:2025-04-01

# dtbo - leave as hash descriptor (no explicit config needed)

# Add for other partitions if not already present
BOARD_AVB_SYSTEM_ROLLBACK_INDEX := 1743465601
BOARD_AVB_VENDOR_ROLLBACK_INDEX := 1743465601
BOARD_AVB_ODM_ROLLBACK_INDEX := 1743465601
BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS += --prop com.android.build.system.os_version:15 --prop com.android.build.system.security_patch:2025-07-01
