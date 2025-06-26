# ==============================================================================
# AVB CONFIGURATION - "FLAGS 3" WORKING CONFIG (FROM SUMMARY)
# ==============================================================================
# This configuration is based on the verified working "Flags 3" setup from
# the AVB_Conflict_Summary document.
#
# Key Principles:
# 1. Main vbmeta: Flags 3 for verification and rollback protection.
# 2. Chained Partitions (boot, init_boot, recovery):
#    - Chain descriptor in vbmeta: Flags 0 (verification handled by vbmeta).
#    - Footer on partition itself: Flags 3 (or 0 for recovery).
#    - Uses BOARD_AVB_<PARTITION>_ADD_HASH_FOOTER_ARGS.
# 3. Hash Descriptors (dtbo, vendor_boot):
#    - Raw content is hashed by vbmeta.
#    - All BOARD_AVB_* variables for the partition are cleared.
# 4. vbmeta_system: Chained with Flags 3 to verify logical partitions.
# 5. Logical Partitions (system, product, etc.):
#    - Verified by vbmeta_system.
#    - Use BOARD_AVB_<PARTITION>_ADD_HASHTREE_FOOTER_ARGS.
# ==============================================================================

# Top-level AVB settings (required)
BOARD_AVB_ENABLE := true
BOARD_AVB_ALGORITHM := SHA256_RSA4096
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# The build system automatically includes dtbo and vendor_boot, so we only
# need to specify the top-level vbmeta properties here.
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS := \
    --flags 3 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --padding_size 4096

# Boot Partition (Chain descriptor Flags: 0, Simple chained footer)
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 3
BOARD_AVB_CHAIN_PARTITION_BOOT_VBMETA_ARGS := --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) --rollback_index_location 3 --flags 0
BOARD_AVB_BOOT_ADD_HASH_FOOTER_ARGS := \
    --flags 3 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --rollback_index_location 3

# Init Boot Partition (Chain descriptor Flags: 0, Simple chained footer)
BOARD_AVB_INIT_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_INIT_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := 4
BOARD_AVB_CHAIN_PARTITION_INIT_BOOT_VBMETA_ARGS := --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) --rollback_index_location 4 --flags 0
BOARD_AVB_INIT_BOOT_ADD_HASH_FOOTER_ARGS := \
    --flags 3 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --rollback_index_location 4

# Recovery Partition (Chain descriptor Flags: 0, Simple chained footer)
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_CHAIN_PARTITION_RECOVERY_VBMETA_ARGS := --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) --rollback_index_location 1 --flags 0
BOARD_AVB_RECOVERY_ADD_HASH_FOOTER_ARGS := \
    --flags 0 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --rollback_index_location 1

# DTBO Partition (Chain descriptor Flags: 0, Footer Flags: 3)
BOARD_AVB_DTBO_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_DTBO_ALGORITHM := SHA256_RSA4096
BOARD_AVB_DTBO_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_DTBO_ROLLBACK_INDEX_LOCATION := 5
BOARD_AVB_CHAIN_PARTITION_DTBO_VBMETA_ARGS := --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) --rollback_index_location 5 --flags 0
BOARD_AVB_DTBO_ADD_HASH_FOOTER_ARGS := \
    --flags 3 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --rollback_index_location 5

# Vendor Boot (Chain descriptor Flags: 0, Footer Flags: 3) 
BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 6
BOARD_AVB_CHAIN_PARTITION_VENDOR_BOOT_VBMETA_ARGS := --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) --rollback_index_location 6 --flags 0
BOARD_AVB_VENDOR_BOOT_ADD_HASH_FOOTER_ARGS := \
    --flags 3 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --rollback_index_location 6

# The build system automatically inserts chain descriptors for dtbo (RIL 5)
# and vendor_boot (RIL 6) once their BOARD_AVB_*_KEY_PATH variables are set.
# Leaving additional --chain_partition lines here would create duplicate
# descriptors and cause vbmeta generation to fail, so they are deliberately
# omitted.

# VBMeta System (chained from main vbmeta, verifies logical partitions)
# TEMPORARILY COMMENTED OUT FOR MINIMAL VBMETA TESTING
# override BOARD_AVB_VBMETA_SYSTEM := system system_ext product odm vendor system_dlkm vendor_dlkm

# --- Arguments for vbmeta_system.img's own footer ---
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
BOARD_AVB_MAKE_VBMETA_SYSTEM_IMAGE_ARGS := \
    --flags 3 \
    --rollback_index $(BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX) \
    --rollback_index_location $(BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION)

# --- Arguments for main vbmeta's chain descriptor to this partition ---
# TEMPORARILY COMMENTED OUT FOR MINIMAL VBMETA TESTING
# BOARD_AVB_CHAIN_PARTITION_VBMETA_SYSTEM_VBMETA_ARGS := \
#     --rollback_index $(BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX) \
#     --rollback_index_location $(BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION) \
#     --flags 0

# Logical Partitions (example: system)
# System partition is verified by vbmeta_system
BOARD_AVB_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_SYSTEM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_SYSTEM_ROLLBACK_INDEX_LOCATION := 13
# Explicitly set partition size to override any stale cached values
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1610612736  # 1.5 GiB
BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS := \
    --flags 3 \
    --hash_algorithm sha256 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --rollback_index_location 13
# BOARD_AVB_CHAIN_PARTITION_SYSTEM_VBMETA_ARGS not defined - system is verified by vbmeta_system

# System Ext
# System_ext partition is verified by vbmeta_system
BOARD_AVB_SYSTEM_EXT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_SYSTEM_EXT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_SYSTEM_EXT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_SYSTEM_EXT_ROLLBACK_INDEX_LOCATION := 12
# Explicitly set partition size to override any stale cached values
# BOARD_SYSTEM_EXTIMAGE_PARTITION_SIZE := 838860800
BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS := \
    --flags 3 \
    --hash_algorithm sha256 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --rollback_index_location 12
# BOARD_AVB_CHAIN_PARTITION_SYSTEM_EXT_VBMETA_ARGS not defined - system_ext is verified by vbmeta_system

# Product
# Product partition is verified by vbmeta_system
BOARD_AVB_PRODUCT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_PRODUCT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_PRODUCT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_PRODUCT_ROLLBACK_INDEX_LOCATION := 11
# Explicitly set partition size to override any stale cached values
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 805306368  # 768MB (was 502MB)
BOARD_AVB_PRODUCT_ADD_HASHTREE_FOOTER_ARGS := \
    --flags 3 \
    --hash_algorithm sha256 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --rollback_index_location 11
# BOARD_AVB_CHAIN_PARTITION_PRODUCT_VBMETA_ARGS not defined - product is verified by vbmeta_system

# ODM
# ODM partition is verified by vbmeta_system
BOARD_AVB_ODM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_ODM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_ODM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_ODM_ROLLBACK_INDEX_LOCATION := 7
# Explicitly set partition size to override any stale cached values
BOARD_ODMIMAGE_PARTITION_SIZE := 950272
BOARD_AVB_ODM_ADD_HASHTREE_FOOTER_ARGS := \
    --flags 3 \
    --hash_algorithm sha256 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --rollback_index_location 7
# BOARD_AVB_CHAIN_PARTITION_ODM_VBMETA_ARGS not defined - odm is verified by vbmeta_system

# Vendor
# Vendor partition is verified by vbmeta_system
BOARD_AVB_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_VENDOR_ROLLBACK_INDEX_LOCATION := 8
# Explicitly set partition size to override any stale cached values
BOARD_VENDORIMAGE_PARTITION_SIZE := 536870912  # 512MB (was 266MB)
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS := \
    --flags 3 \
    --hash_algorithm sha256 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --rollback_index_location 8
# BOARD_AVB_CHAIN_PARTITION_VENDOR_VBMETA_ARGS not defined - vendor is verified by vbmeta_system

# System DLKM
# Disable key-path export for system_dlkm so it is treated purely as a hashed partition.
#BOARD_AVB_SYSTEM_DLKM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_SYSTEM_DLKM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_SYSTEM_DLKM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_SYSTEM_DLKM_ROLLBACK_INDEX_LOCATION := 9
# Explicitly set partition size to override any stale cached values
BOARD_SYSTEM_DLKMIMAGE_PARTITION_SIZE := 33554432  # 32MB (was 12MB)
BOARD_AVB_SYSTEM_DLKM_ADD_HASHTREE_FOOTER_ARGS := \
    --flags 3 \
    --hash_algorithm sha256 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --rollback_index_location 9
# BOARD_AVB_CHAIN_PARTITION_SYSTEM_DLKM_VBMETA_ARGS not defined - system_dlkm is verified by vbmeta_system

# Vendor DLKM
# Vendor_dlkm partition is verified by vbmeta_system
BOARD_AVB_VENDOR_DLKM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_DLKM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_DLKM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_VENDOR_DLKM_ROLLBACK_INDEX_LOCATION := 10
# Explicitly set partition size to override any stale cached values
# BOARD_VENDOR_DLKMIMAGE_PARTITION_SIZE := 71155884
BOARD_AVB_VENDOR_DLKM_ADD_HASHTREE_FOOTER_ARGS := \
    --flags 3 \
    --hash_algorithm sha256 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP) \
    --rollback_index_location 10
# BOARD_AVB_CHAIN_PARTITION_VENDOR_DLKM_VBMETA_ARGS not defined - vendor_dlkm is verified by vbmeta_system

# ==============================================================================
# AVB - VBMeta System Configuration
# ==============================================================================

# ==============================================================================
# OTA Configuration
# ==============================================================================
# Include partitions that require post-install processing. Must align with
# AB_OTA_POSTINSTALL_CONFIG definitions from sm8650-common.
AB_OTA_PARTITIONS := \
    vbmeta \
    vbmeta_system \
    boot \
    init_boot \
    vendor_boot \
    dtbo \
    system \
    system_ext \
    product \
    vendor \
    odm \
    system_dlkm \
    vendor_dlkm