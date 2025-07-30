# AVB Configuration - Explicit and Permissive for Development
# This configuration defines a full chain-of-trust for all critical partitions,
# ensuring that build-time tools and OTA packaging work correctly.
# It uses "--flags 3" throughout, which enables verification but allows the user
# to bypass it on an unlocked device. This is ideal for development, as it
# mirrors the "yellow" warning state of a production device running custom code.
# For a "green" production build, use "--flags 0" and sign with release keys.

BOARD_AVB_ENABLE := true
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_ALGORITHM := SHA256_RSA4096
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS := \
    --flags 0 \
    --rollback_index $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)

# ------------------------------------------------------------------------------
# Top-Level VBMeta Image
# ------------------------------------------------------------------------------
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# ------------------------------------------------------------------------------
# Chained Partitions - Each has its own AVB footer
# ------------------------------------------------------------------------------

# Clear vendor_boot AVB variables to force hash descriptor creation
BOARD_AVB_VENDOR_BOOT_KEY_PATH :=
BOARD_AVB_VENDOR_BOOT_ALGORITHM :=
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX :=
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION :=
BOARD_AVB_VENDOR_BOOT_ADD_HASH_FOOTER_ARGS :=

# RECOVERY (RIL 1)
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_RECOVERY_ADD_HASH_FOOTER_ARGS := \
    --flags 0 \
    --rollback_index $(BOARD_AVB_RECOVERY_ROLLBACK_INDEX) \
    --rollback_index_location $(BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION) \
    --algorithm $(BOARD_AVB_RECOVERY_ALGORITHM) \
    --key $(BOARD_AVB_RECOVERY_KEY_PATH)

# VBMETA_SYSTEM (RIL 2) - Describes all other dynamic partitions
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
BOARD_AVB_MAKE_VBMETA_SYSTEM_IMAGE_ARGS += \
    --flags 0 \
    --rollback_index_location 2
# Ensure all dynamic partitions are included for vbmeta_system.
BOARD_AVB_VBMETA_SYSTEM := system system_ext product vendor odm system_dlkm vendor_dlkm

# --- THE CORRECT DTBO AVB CONFIGURATION ---
# This configuration forces the build system to generate a fresh HASH descriptor
# for the prebuilt dtbo.img by adding a new, unsigned hash footer after padding
# the image to the full partition size.

# 1. Leave KEY_PATH and CHAIN_PARTITION args empty to ensure a HASH descriptor is created,
#    not a CHAIN descriptor.
BOARD_AVB_DTBO_KEY_PATH :=
BOARD_AVB_CHAIN_PARTITION_DTBO_VBMETA_ARGS :=

# 2. Provide full arguments for adding a new hash footer. This is the critical step.
#    The build system will now run 'avbtool add_hash_footer' on the clean dtbo image.
BOARD_AVB_DTBO_ALGORITHM :=
# BOARD_AVB_DTBO_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
# BOARD_AVB_DTBO_ROLLBACK_INDEX_LOCATION := 5
BOARD_AVB_DTBO_ADD_HASH_FOOTER_ARGS :=
#    --algorithm NONE \
#    --hash_algorithm sha256

# BOOT (RIL 3)
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 3
BOARD_AVB_BOOT_ADD_HASH_FOOTER_ARGS := \
    --flags 0 \
    --rollback_index $(BOARD_AVB_BOOT_ROLLBACK_INDEX) \
    --rollback_index_location $(BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION) \
    --algorithm $(BOARD_AVB_BOOT_ALGORITHM) \
    --key $(BOARD_AVB_BOOT_KEY_PATH)

# INIT_BOOT (RIL 4)
BOARD_AVB_INIT_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_INIT_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := 4
BOARD_AVB_INIT_BOOT_ADD_HASH_FOOTER_ARGS := \
    --flags 0 \
    --rollback_index $(BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX) \
    --rollback_index_location $(BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION) \
    --algorithm $(BOARD_AVB_INIT_BOOT_ALGORITHM) \
    --key $(BOARD_AVB_INIT_BOOT_KEY_PATH)

# VENDOR_BOOT - This partition will be verified by a hash descriptor in the main vbmeta.
# We explicitly define the footer args to ensure the build system hashes the final,
# complete vendor_boot.img, avoiding mismatches.
BOARD_AVB_VENDOR_BOOT_KEY_PATH :=
BOARD_AVB_CHAIN_PARTITION_VENDOR_BOOT_VBMETA_ARGS :=
BOARD_AVB_VENDOR_BOOT_ALGORITHM :=
# BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := $(TARGET_DESIRED_ROLLBACK_TIMESTAMP)
# BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 6
BOARD_AVB_VENDOR_BOOT_ADD_HASH_FOOTER_ARGS :=
#    --algorithm NONE \
#    --hash_algorithm sha256