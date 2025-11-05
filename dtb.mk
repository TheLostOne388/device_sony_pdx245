# DTB prebuilt copy rule for PDX245
# The kernel.mk doesn't create a copy rule when BOARD_INCLUDE_DTB_IN_BOOTIMG is false
# but we need dtb.img for vendor_boot/recovery images

INSTALLED_DTBIMAGE_TARGET := $(PRODUCT_OUT)/dtb.img
PDX245_PREBUILT_DTB := device/sony/pdx245/prebuilt/dtb.img

$(INSTALLED_DTBIMAGE_TARGET): $(PDX245_PREBUILT_DTB)
	@echo "Copying prebuilt DTB from firmware 69.1.A.2.268"
	$(hide) cp -f $< $@

.PHONY: dtbimage
dtbimage: $(INSTALLED_DTBIMAGE_TARGET)

