# Audio HAL headers fix for pdx245 device
# This makefile handles all audio header operations to keep BoardConfig.mk clean

# Output directories
AUDIO_HEADERS_OUT := $(DEVICE_PATH)/include/headers

# List of known missing headers to create stubs for
MISSING_HEADERS := \
    vui/vui_dmgr_audio_intf.h \
    audio/kvh2xml.h \
    sound_trigger/SoundTriggerUtils.h \
    bt/common_enc_dec_api.h \
    audio/audio_feature_stats_intf.h \
    pal/utils/inc/VoiceUIPlatformInfo.h \
    amdb_api.h \
    pal/utils/inc/VoiceUIInterface.h

# Search paths for potential existing headers (oldest to newest)
HEADER_SEARCH_PATHS := \
    hardware/qcom-caf/sm8350 \
    hardware/qcom-caf/sm8450

# Add a stamp file to track if headers have been set up
AUDIO_HEADERS_STAMP := $(AUDIO_HEADERS_OUT)/.headers_created

# Only create headers once by checking for the stamp file
ifeq ($(wildcard $(AUDIO_HEADERS_STAMP)),)
# Execute header setup operations only if stamp file doesn't exist
$(shell mkdir -p $(AUDIO_HEADERS_OUT))
$(shell $(call setup-audio-header-dirs) >/dev/null 2>&1)
$(shell $(call create-stub-headers) >/dev/null 2>&1)
$(shell $(call create-sound-trigger-stub) >/dev/null 2>&1)
$(shell $(call create-detailed-voiceui-stub) >/dev/null 2>&1)
$(shell $(call create-voiceui-interface-stub) >/dev/null 2>&1)
$(shell $(call create-amdb-api-stub) >/dev/null 2>&1)
$(shell $(call fix-palringbuffer) >/dev/null 2>&1)
# Create stamp file to indicate headers are set up
$(shell touch $(AUDIO_HEADERS_STAMP))
endif

# Uncomment to verify headers manually when needed
#$(shell $(call verify-critical-headers))

# Add audio header paths to TARGET_SPECIFIC_HEADER_PATH
TARGET_SPECIFIC_HEADER_PATH += \
    hardware/qcom-caf/sm8450/audio/graphservices/ar_osal/api \
    hardware/qcom-caf/sm8450/audio/graphservices/gsl/api \
    hardware/qcom-caf/sm8450/audio/graphservices/spf/api/modules \
    hardware/qcom-caf/sm8450/audio/graphservices/spf/api/ar_utils \
    hardware/qcom-caf/sm8450/audio/graphservices/spf/api/apm \
    $(AUDIO_HEADERS_OUT) \
    $(AUDIO_HEADERS_OUT)/vui \
    $(AUDIO_HEADERS_OUT)/audio \
    $(AUDIO_HEADERS_OUT)/sound_trigger \
    $(AUDIO_HEADERS_OUT)/bt \
    $(AUDIO_HEADERS_OUT)/pal/utils/inc \
    $(AUDIO_HEADERS_OUT)/pal/inc \
    $(AUDIO_HEADERS_OUT)/modules \
    $(AUDIO_HEADERS_OUT)/ar_osal/api \
    $(AUDIO_HEADERS_OUT)/apm \
    $(AUDIO_HEADERS_OUT)/spf \
    $(AUDIO_HEADERS_OUT)/ar_utils \
    $(AUDIO_HEADERS_OUT)/logger

# Add Qualcomm HAL-specific compiler flags to suppress warnings
TARGET_SPECIFIC_AUDIO_CFLAGS := -Wno-error=reorder-init-list -Wno-error=reorder-ctor -Wno-error=unused-parameter
