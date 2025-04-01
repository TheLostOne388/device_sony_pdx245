LOCAL_PATH := $(call my-dir)

# Recovery related packages
include $(CLEAR_VARS)
LOCAL_MODULE := recovery_updater
LOCAL_SRC_FILES := recovery_updater.cpp
LOCAL_C_INCLUDES := bootable/recovery
LOCAL_CFLAGS := -Wall
include $(BUILD_STATIC_LIBRARY)

# Copy recovery fstab
include $(CLEAR_VARS)
LOCAL_MODULE := recovery_fstab.$(TARGET_DEVICE)
LOCAL_MODULE_STEM := fstab.$(TARGET_DEVICE)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/system/etc
LOCAL_SRC_FILES := root/system/etc/recovery.fstab
include $(BUILD_PREBUILT) 