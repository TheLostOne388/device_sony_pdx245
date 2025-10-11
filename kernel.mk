LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# Specify prebuilt kernel (match BoardConfig.mk path)
LOCAL_PREBUILT_KERNEL := $(TOP)/kernel/sony/pdx245/prebuilts/kernel

# Specify prebuilt DTB
LOCAL_PREBUILT_DTB := prebuilts/dtb.img

# Specify prebuilt DTBO
LOCAL_PREBUILT_DTBO := prebuilts/dtbo.img

# Specify prebuilt ramdisk
LOCAL_RAMDISK_DIR := prebuilts/ramdisk

# Include prebuilt kernel modules
LOCAL_PREBUILT_MODULES := prebuilts/system_dlkm.img prebuilts/vendor_dlkm.img

include $(BUILD_KERNEL_PREBUILT)

