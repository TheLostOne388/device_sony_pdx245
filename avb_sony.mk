# Sony-specific AVB config for UEFI bypass
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --disable_verity
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --rollback_index 0
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --skip_descriptors

# Sony UEFI specific: disable firmware volume CRC
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --algorithm NONE
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --key /dev/null
