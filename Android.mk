LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := super_empty.img
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(PRODUCT_OUT)

$(LOCAL_MODULE): | $(HOST_OUT)/bin/lpmake
	@echo "Generating super_empty.img"
	$(hide) $(HOST_OUT)/bin/lpmake --device super:$(BOARD_SUPER_PARTITION_SIZE) \
	  --metadata-size 65536 \
	  --metadata-slots 2 \
	  --group qti_dynamic_partitions:$(BOARD_QTI_DYNAMIC_PARTITIONS_SIZE) \
	  --partition system_a:readonly:$(BOARD_SYSTEMIMAGE_PARTITION_SIZE):qti_dynamic_partitions \
	  --partition system_b:readonly:0:qti_dynamic_partitions \
	  --partition system_ext_a:readonly:$(BOARD_SYSTEM_EXTIMAGE_PARTITION_SIZE):qti_dynamic_partitions \
	  --partition system_ext_b:readonly:0:qti_dynamic_partitions \
	  --partition product_a:readonly:$(BOARD_PRODUCTIMAGE_PARTITION_SIZE):qti_dynamic_partitions \
	  --partition product_b:readonly:0:qti_dynamic_partitions \
	  --partition vendor_a:readonly:$(BOARD_VENDORIMAGE_PARTITION_SIZE):qti_dynamic_partitions \
	  --partition vendor_b:readonly:0:qti_dynamic_partitions \
	  --partition odm_a:readonly:$(BOARD_ODMIMAGE_PARTITION_SIZE):qti_dynamic_partitions \
	  --partition odm_b:readonly:0:qti_dynamic_partitions \
	  --partition system_dlkm_a:readonly:$(BOARD_SYSTEM_DLKMIMAGE_PARTITION_SIZE):qti_dynamic_partitions \
	  --partition system_dlkm_b:readonly:0:qti_dynamic_partitions \
	  --partition vendor_dlkm_a:readonly:$(BOARD_VENDOR_DLKMIMAGE_PARTITION_SIZE):qti_dynamic_partitions \
	  --partition vendor_dlkm_b:readonly:0:qti_dynamic_partitions \
	  --sparse \
	  --output $(PRODUCT_OUT)/super_empty.img

include $(BUILD_PHONY_PACKAGE)

# Ensure product_packages.txt exists early for dexpreopt dependencies
$(PRODUCT_OUT)/product_packages.txt:
	@echo "Generating placeholder product_packages.txt"
	$(hide) mkdir -p $(dir $@)
	$(hide) (for p in $(PRODUCT_PACKAGES); do echo $$p; done) > $@
