#!/bin/bash
# AVB Verification Script for Sony pdx245
# Critical verification for preventing "device is corrupt" errors

set -e

PRODUCT_OUT="${1:-out/target/product/pdx245}"
AVBTOOL="${PWD}/out/host/linux-x86/bin/avbtool"

echo "=== SONY PDX245 AVB VERIFICATION ==="
echo "Checking for hash descriptor size mismatches (MOST CRITICAL)..."
echo

# Check DTBO hash descriptor consistency
echo "=== DTBO VERIFICATION ==="
DTBO_VBMETA_SIZE=$(${AVBTOOL} info_image --image ${PRODUCT_OUT}/vbmeta.img | grep -A6 "Partition Name:        dtbo" | grep "Image size" | awk '{print $3}')
DTBO_FILE_SIZE=$(stat --format="%s" ${PRODUCT_OUT}/dtbo.img)

echo "VBMeta descriptor size: ${DTBO_VBMETA_SIZE} bytes"
echo "Actual file size:       ${DTBO_FILE_SIZE} bytes"

if [ "${DTBO_VBMETA_SIZE}" = "${DTBO_FILE_SIZE}" ]; then
    echo "✅ DTBO sizes match"
else
    echo "❌ DTBO sizes MISMATCH - This will cause 'device is corrupt'!"
fi

echo

# Check vendor_boot hash descriptor consistency
echo "=== VENDOR_BOOT VERIFICATION ==="
VB_VBMETA_SIZE=$(${AVBTOOL} info_image --image ${PRODUCT_OUT}/vbmeta.img | grep -A6 "Partition Name:        vendor_boot" | grep "Image size" | awk '{print $3}')
VB_FILE_SIZE=$(stat --format="%s" ${PRODUCT_OUT}/vendor_boot.img)

echo "VBMeta descriptor size: ${VB_VBMETA_SIZE} bytes"
echo "Actual file size:       ${VB_FILE_SIZE} bytes"

if [ "${VB_VBMETA_SIZE}" = "${VB_FILE_SIZE}" ]; then
    echo "✅ VENDOR_BOOT sizes match"
else
    echo "❌ VENDOR_BOOT sizes MISMATCH - This will cause 'device is corrupt'!"
fi

echo
echo "=== MAIN VBMETA STRUCTURE ==="
${AVBTOOL} info_image --image ${PRODUCT_OUT}/vbmeta.img | grep -E "(Flags:|Rollback Index:|Partition Name:|Image Size:)" | head -20

echo
echo "=== REMEDY ==="
echo "If sizes don't match, run:"
echo "  ./device/sony/pdx245/rebuild_vbmeta.sh ${PRODUCT_OUT}"
echo
echo "Verification complete."
