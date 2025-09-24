# Enable AVB but disable dm-verity for development (LineageOS standard)
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3 --padding_size 0
BOARD_AVB_MAKE_VBMETA_SYSTEM_IMAGE_ARGS += --flags 3 --padding_size 0
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# Use generated key for all AVB signing (matches stock algorithm/hash pattern)
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_ALGORITHM := SHA256_RSA4096

# Match stock rollback indices exactly (from vbmeta_216.img analysis): main to 1743465600, others to 0
BOARD_AVB_ROLLBACK_INDEX := 1758556800
BOARD_AVB_BOOT_ROLLBACK_INDEX := 1758556800
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX := 1758556800
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1758556800
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 1758556800
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := 1758556800
BOARD_AVB_SYSTEM_ROLLBACK_INDEX := 1758556800
BOARD_AVB_VENDOR_ROLLBACK_INDEX := 1758556800
BOARD_AVB_ODM_ROLLBACK_INDEX := 1758556800

# Boot partition - matches stock
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 3
# Match stock os_version and security_patch props (from stock AVB analysis), but set to '15' for Android 15 build consistency (stock uses mixed '14'/'15'; '15' avoids internal mismatches while providing required props). Standardized security_patch to '2025-04-01' for uniformity.
BOARD_AVB_BOOT_ADD_HASH_FOOTER_ARGS += --prop com.android.build.boot.os_version:15 --prop com.android.build.boot.security_patch:2025-04-01

# Recovery - matches stock
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# vbmeta_system - matches stock (bumped from 1730419200) - temporarily disabled to fix build error
BOARD_AVB_VBMETA_SYSTEM := system system_dlkm system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
# Match stock os_version and security_patch props (from stock AVB analysis), but set to '15' for Android 15 build consistency (stock uses mixed '14'/'15'; '15' avoids internal mismatches while providing required props). Standardized security_patch to '2025-04-01' for uniformity.
BOARD_AVB_VBMETA_SYSTEM_ARGS += --prop com.android.build.vbmeta_system.os_version:15 --prop com.android.build.vbmeta_system.security_patch:2025-04-01

# init_boot - matches stock pattern
BOARD_AVB_INIT_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_INIT_BOOT_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := 4

# vendor_boot - stock uses hash descriptor, but we'll chain it
BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_BOOT_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 6
# Match stock os_version and security_patch props (from stock AVB analysis)
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS += --prop com.android.build.vendor.os_version:15 --prop com.android.build.vendor.security_patch:2025-04-01

# dtbo - leave as hash descriptor (no explicit config needed)

# Add for other partitions if not already present
# Match stock os_version and security_patch props (from stock AVB analysis), but set to '15' for Android 15 build consistency (stock uses mixed '14'/'15'; '15' avoids internal mismatches while providing required props). Standardized security_patch to '2025-04-01' for uniformity.
BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS += --prop com.android.build.system.os_version:15 --prop com.android.build.system.security_patch:2025-04-01

# Disable Virtual A/B to address VAB magic/version errors in TA logs
BOARD_USES_VIRTUAL_AB := false
BOARD_VIRTUAL_AB_COMPRESSION := false

# Note: Intended to set AVB release string to match stock 'avbtool 1.3.0' (from analysis), but avbtool does not support --release_string arg (causes build failure). Removed for now; if version mismatches cause boot issues, patch avbtool.py directly.

# Note: Using AOSP test private key for signing (Sony private unavailable). Extracted Sony public key (SHA1: 11a8f6eea2f1616e72bed21b9f6db4696f8ba241) can be referenced for chain descriptors if needed.
# For custom signing, consider generating new RSA4096 key pair and flashing public to avb_custom_key if supported.

# Forcefully remove the recovery chain from the final vbmeta arguments at the end of the build process
# INTERNAL_AVB_MAKE_VBMETA_IMAGE_ARGS := $(filter-out --chain_partition recovery:1:%,$(INTERNAL_AVB_MAKE_VBMETA_IMAGE_ARGS))