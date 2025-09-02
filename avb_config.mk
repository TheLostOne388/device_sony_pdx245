# Sony pdx245 AVB Configuration - CORRECTED
# =============================================================================
# CORE AVB SETTINGS
# =============================================================================
BOARD_AVB_ENABLE := true
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_ALGORITHM := SHA256_RSA4096

# FIXED: Correct variable name for FLAGS
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_ROLLBACK_INDEX_LOCATION := 0

# =============================================================================
# CHAINED PARTITIONS - FIXED RIL CONFLICTS
# =============================================================================
# BOOT - Chain Partition (RIL 3) - CORRECTED
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 3
BOARD_AVB_BOOT_ADD_HASH_FOOTER_ARGS += --algorithm SHA256_RSA4096 \
    --hash_algorithm sha256 \
    --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) \
    --rollback_index_location 3

# INIT_BOOT - Chain Partition (RIL 4) - CORRECTED
BOARD_AVB_INIT_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_INIT_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := 4
BOARD_AVB_INIT_BOOT_ADD_HASH_FOOTER_ARGS += --algorithm SHA256_RSA4096 \
    --hash_algorithm sha256 \
    --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) \
    --rollback_index_location 4

# RECOVERY - Chain Partition (RIL 1) - CORRECTED
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_RECOVERY_ADD_HASH_FOOTER_ARGS += --algorithm SHA256_RSA4096 \
    --hash_algorithm sha256 \
    --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) \
    --rollback_index_location 1

# =============================================================================
# HASH PARTITIONS - Stock Method
# =============================================================================
# DTBO - Hash Descriptor (no rollback index)
BOARD_AVB_DTBO_KEY_PATH :=
BOARD_AVB_DTBO_ALGORITHM := NONE
BOARD_AVB_DTBO_ADD_HASH_FOOTER_ARGS += --algorithm NONE --hash_algorithm sha256

# VENDOR_BOOT - Hash Descriptor (no rollback index, stock partition size)
BOARD_AVB_VENDOR_BOOT_KEY_PATH :=
BOARD_AVB_VENDOR_BOOT_ALGORITHM := NONE
BOARD_AVB_VENDOR_BOOT_ADD_HASH_FOOTER_ARGS += --algorithm NONE --hash_algorithm sha256 --partition_size 100663296

# =============================================================================
# VBMETA_SYSTEM CONFIGURATION
# =============================================================================
BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
BOARD_AVB_MAKE_VBMETA_SYSTEM_IMAGE_ARGS += --flags 0

# Hashtree footers for vbmeta_system partitions (complete args with FEC)
BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS += --algorithm SHA256_RSA4096 --hash_algorithm sha256 --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) --rollback_index_location 10 --key external/avb/test/data/testkey_rsa4096.pem --setup_as_rootfs_from_kernel --flags 0 --fec_num_roots 2
BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS += --algorithm SHA256_RSA4096 --hash_algorithm sha256 --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) --rollback_index_location 11 --key external/avb/test/data/testkey_rsa4096.pem --setup_as_rootfs_from_kernel --flags 0 --fec_num_roots 2
BOARD_AVB_PRODUCT_ADD_HASHTREE_FOOTER_ARGS += --algorithm SHA256_RSA4096 --hash_algorithm sha256 --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) --rollback_index_location 12 --key external/avb/test/data/testkey_rsa4096.pem --setup_as_rootfs_from_kernel --flags 0 --fec_num_roots 2

# =============================================================================
# MAIN VBMETA HASHTREE DESCRIPTORS - Complete args
# =============================================================================
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS += --algorithm SHA256_RSA4096 --hash_algorithm sha256 --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) --rollback_index_location 6 --key external/avb/test/data/testkey_rsa4096.pem --setup_as_rootfs_from_kernel --flags 0 --fec_num_roots 2
BOARD_AVB_ODM_ADD_HASHTREE_FOOTER_ARGS += --algorithm SHA256_RSA4096 --hash_algorithm sha256 --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) --rollback_index_location 7 --key external/avb/test/data/testkey_rsa4096.pem --setup_as_rootfs_from_kernel --flags 0 --fec_num_roots 2
BOARD_AVB_SYSTEM_DLKM_ADD_HASHTREE_FOOTER_ARGS += --algorithm SHA256_RSA4096 --hash_algorithm sha256 --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) --rollback_index_location 8 --key external/avb/test/data/testkey_rsa4096.pem --setup_as_rootfs_from_kernel --flags 0 --fec_num_roots 2
BOARD_AVB_VENDOR_DLKM_ADD_HASHTREE_FOOTER_ARGS += --algorithm SHA256_RSA4096 --hash_algorithm sha256 --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) --rollback_index_location 9 --key external/avb/test/data/testkey_rsa4096.pem --setup_as_rootfs_from_kernel --flags 0 --fec_num_roots 2
