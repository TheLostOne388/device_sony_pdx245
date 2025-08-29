# Sony pdx245 AVB Configuration - Stock Compatible  
# Based on stock firmware analysis - matches exact partition assignment
# Build system handles everything - no post-build scripts required

# =============================================================================
# CORE AVB SETTINGS - Stock Compatible
# =============================================================================
BOARD_AVB_ENABLE := true
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_ALGORITHM := SHA256_RSA4096

# Main vbmeta configuration - FLAGS 3 required for Sony (critical discovery)
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_ROLLBACK_INDEX_LOCATION := 0

# =============================================================================
# CHAINED PARTITIONS - Build System Handles Automatically  
# =============================================================================
# Stock chains: boot, init_boot, recovery, vbmeta_system

# BOOT - Chain Partition (RIL 3)
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 3
BOARD_AVB_BOOT_ADD_HASH_FOOTER_ARGS += --algorithm SHA256_RSA4096

# INIT_BOOT - Chain Partition (RIL 4)
BOARD_AVB_INIT_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_INIT_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := 4
BOARD_AVB_INIT_BOOT_ADD_HASH_FOOTER_ARGS += --algorithm SHA256_RSA4096

# RECOVERY - Chain Partition (RIL 1) - NO footer per LineageOS approach
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# =============================================================================
# HASH PARTITIONS - Stock Method (unsigned footers)
# =============================================================================
# Stock hashes: dtbo, vendor_boot (Algorithm: NONE)

# DTBO - Hash Descriptor (matches stock: Algorithm NONE, no rollback index)
BOARD_AVB_DTBO_ALGORITHM := NONE
BOARD_AVB_DTBO_ADD_HASH_FOOTER_ARGS += --algorithm NONE --hash_algorithm sha256

# VENDOR_BOOT - Hash Descriptor (matches stock: Algorithm NONE, no rollback index)
BOARD_AVB_VENDOR_BOOT_ALGORITHM := NONE  
BOARD_AVB_VENDOR_BOOT_ADD_HASH_FOOTER_ARGS += --algorithm NONE --hash_algorithm sha256

# =============================================================================
# MAIN VBMETA HASHTREE DESCRIPTORS - Stock Analysis Method
# =============================================================================
# Stock main vbmeta contains hashtree descriptors for vendor-related partitions

# VENDOR - Hashtree in main vbmeta (vendor-related) - EXPLICIT CONFIGURATION
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS += \
    --algorithm SHA256_RSA4096 \
    --hash_algorithm sha256 \
    --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) \
    --rollback_index_location 2 \
    --key external/avb/test/data/testkey_rsa4096.pem \
    --setup_as_rootfs_from_kernel

# ODM - Hashtree in main vbmeta (vendor-related) - EXPLICIT CONFIGURATION
BOARD_AVB_ODM_ADD_HASHTREE_FOOTER_ARGS += \
    --algorithm SHA256_RSA4096 \
    --hash_algorithm sha256 \
    --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) \
    --rollback_index_location 2 \
    --key external/avb/test/data/testkey_rsa4096.pem \
    --setup_as_rootfs_from_kernel

# SYSTEM_DLKM - Hashtree in main vbmeta (vendor-related) - EXPLICIT CONFIGURATION
BOARD_AVB_SYSTEM_DLKM_ADD_HASHTREE_FOOTER_ARGS += \
    --algorithm SHA256_RSA4096 \
    --hash_algorithm sha256 \
    --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) \
    --rollback_index_location 2 \
    --key external/avb/test/data/testkey_rsa4096.pem \
    --setup_as_rootfs_from_kernel

# VENDOR_DLKM - Hashtree in main vbmeta (vendor-related) - EXPLICIT CONFIGURATION
BOARD_AVB_VENDOR_DLKM_ADD_HASHTREE_FOOTER_ARGS += \
    --algorithm SHA256_RSA4096 \
    --hash_algorithm sha256 \
    --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) \
    --rollback_index_location 2 \
    --key external/avb/test/data/testkey_rsa4096.pem \
    --setup_as_rootfs_from_kernel

# =============================================================================
# VBMETA_SYSTEM CONFIGURATION - Stock Analysis Method
# =============================================================================
# Controls which partitions go in vbmeta_system

# OPTION 4: Move system OUT of vbmeta_system - handle via main vbmeta
BOARD_AVB_VBMETA_SYSTEM := product system_ext
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

# =============================================================================
# VBMETA_SYSTEM HASHTREE DESCRIPTORS - Critical Discovery
# =============================================================================
# Stock analysis revealed: system and system_ext MUST have hashtree footers

# SYSTEM - Hashtree in MAIN vbmeta (moved from vbmeta_system due to corruption bug)
BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

# SYSTEM_EXT - Hashtree in vbmeta_system (system-related) - EXPLICIT CONFIGURATION
BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS += \
    --algorithm SHA256_RSA4096 \
    --hash_algorithm sha256 \
    --rollback_index $(PLATFORM_SECURITY_PATCH_TIMESTAMP) \
    --rollback_index_location 2 \
    --key external/avb/test/data/testkey_rsa4096.pem \
    --setup_as_rootfs_from_kernel

# PRODUCT - Automatically handled by BOARD_AVB_VBMETA_SYSTEM assignment above
