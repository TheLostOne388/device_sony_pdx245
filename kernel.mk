LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# Specify prebuilt kernel Image
LOCAL_PREBUILT_KERNEL := prebuilts/Image

# Specify prebuilt DTB
LOCAL_PREBUILT_DTB := prebuilts/dtb.img

# Specify prebuilt DTBO
LOCAL_PREBUILT_DTBO := prebuilts/dtbo.img

# Specify prebuilt ramdisk
LOCAL_RAMDISK_DIR := prebuilts/ramdisk

# Include prebuilt kernel modules
LOCAL_PREBUILT_MODULES := prebuilts/system_dlkm.img prebuilts/vendor_dlkm.img

include $(BUILD_KERNEL_PREBUILT)

