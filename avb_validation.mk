# AVB Size Validation Makefile
# Simplified version for Android build system compatibility

# Simple validation target
.PHONY: avb-validate
avb-validate:
	@echo "🔍 Running AVB size validation..."
	@if [ -f "$(PWD)/verify_avb_sizes.sh" ]; then \
		$(PWD)/verify_avb_sizes.sh; \
	else \
		echo "❌ Verification script not found"; \
		exit 1; \
	fi

# Optional: Integrate into OTA package build
# Uncomment the line below to run validation automatically during OTA builds
# $(INSTALLED_OTAPACKAGE_TARGET): avb-validate
