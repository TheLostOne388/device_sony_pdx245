#
# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This file needs to be first for BOARD_CUSTOM_BOOTIMG_MK

LOCAL_PATH := $(call my-dir)

# Get the device path; typically available as LOCAL_PATH if this Android.mk is device/sony/pdx245/Android.mk
# Or use a hardcoded path if necessary, but $(LOCAL_PATH) should work if this file is in the device dir.
DEVICE_PREBUILT_PATH := $(LOCAL_PATH)
KERNEL_PREBUILT_PATH := kernel/sony/pdx245/prebuilts

# Define output directory for clarity. PRODUCT_OUT is typically defined by the build environment.
# Fallback in case it's not, though it should be.
PRODUCT_OUT_DIR := $(if $(PRODUCT_OUT),$(PRODUCT_OUT),out/target/product/$(TARGET_DEVICE))

# Override for prebuilt init_boot.mk
# Ensures the prebuilt init_boot.img (with Flags:3, RIL:4) is used.
# $(DEVICE_PATH) should resolve to device/sony/pdx245
# $(PRODUCT_OUT) should resolve to out/target/product/pdx245
.PHONY: initbootimage init_bootimage
initbootimage init_bootimage:
	@echo "Attempting to build system init_boot.img first (will be overridden by prebuilt)..."
	$(MAKE) -f build/core/main.mk $(INSTALLED_INIT_BOOT_IMAGE_TARGET) || true
	@echo "Overriding with prebuilt init_boot.img from $(DEVICE_PATH)/prebuilt_init_boot/init_boot.img"
	mkdir -p $(dir $(PRODUCT_OUT)/init_boot.img)
	cp $(DEVICE_PATH)/prebuilt_init_boot/init_boot.img $(PRODUCT_OUT)/init_boot.img
	@echo "Prebuilt init_boot.img copied successfully to $(PRODUCT_OUT)/init_boot.img"

# --- Override for dtbo.img ---
# The INSTALLED_DTBOIMAGE_TARGET variable should point to the correct output location.
.PHONY: dtboimage
dtboimage:
	@echo "Attempting to build system dtbo.img first (will be overridden by prebuilt)..."
	$(MAKE) -f build/core/main.mk $(INSTALLED_DTBOIMAGE_TARGET) || true
	@echo "Overriding with prebuilt dtbo.img from $(KERNEL_PREBUILT_PATH)/dtbo.img"
	mkdir -p $(dir $(PRODUCT_OUT_DIR)/dtbo.img)
	cp $(KERNEL_PREBUILT_PATH)/dtbo.img $(PRODUCT_OUT_DIR)/dtbo.img
	@echo "Prebuilt dtbo.img copied successfully to $(PRODUCT_OUT_DIR)/dtbo.img"

# --- Override for vendor_boot.img (as per AVB_Conflict_Summary.txt) ---
# The INSTALLED_VENDOR_BOOTIMAGE_TARGET variable should point to the correct output location.
.PHONY: vendorbootimage
vendorbootimage:
	@echo "Attempting to build system vendor_boot.img first (will be overridden by prebuilt)..."
	$(MAKE) -f build/core/main.mk $(INSTALLED_VENDOR_BOOTIMAGE_TARGET) || true
	@echo "Overriding with prebuilt vendor_boot.img from $(DEVICE_PREBUILT_PATH)/prebuilt_vendor_boot/vendor_boot.img"
	mkdir -p $(dir $(PRODUCT_OUT_DIR)/vendor_boot.img)
	cp $(DEVICE_PREBUILT_PATH)/prebuilt_vendor_boot/vendor_boot.img $(PRODUCT_OUT_DIR)/vendor_boot.img
	@echo "Prebuilt vendor_boot.img copied successfully to $(PRODUCT_OUT_DIR)/vendor_boot.img"


#
# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.
#

# LOCAL_PATH := $(call my-dir) # Defined above

# Add devices to the lunch combo
ifneq ($(filter pdx245,$(TARGET_DEVICE)),)
  include $(call all-makefiles-under,$(LOCAL_PATH))

  # Create data directory at parse time (simplest solution)
  $(shell mkdir -p $(PRODUCT_OUT)/data)
endif
