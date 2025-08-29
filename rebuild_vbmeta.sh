#!/bin/bash
#
# Sony pdx245 VBMeta Rebuild Script
# Based on AVB Solution Guide - fixes RIL and structure issues
#

set -e

PRODUCT_OUT="$1"
if [ -z "${PRODUCT_OUT}" ]; then
    echo "Error: Product output path not specified."
    echo "Usage: $0 <product_out_path>"
    exit 1
fi

AVBTOOL="$PWD/out/host/linux-x86/bin/avbtool"
FINAL_VBMETA_IMAGE="${PRODUCT_OUT}/vbmeta.img"

echo "🔧 Sony pdx245 VBMeta Rebuild Script"
echo "==================================="
echo "Rebuilding with correct RIL values and structure..."

# Extract current values from existing vbmeta
ROLLBACK_INDEX=$(${AVBTOOL} info_image --image ${FINAL_VBMETA_IMAGE} | grep "Rollback Index:" | awk '{print $3}')
FLAGS=3  # Keep FLAGS 3 for Sony bootloader compatibility
KEY_PATH="external/avb/test/data/testkey_rsa4096.pem"
ALGORITHM="SHA256_RSA4096"

echo "Using Rollback Index: ${ROLLBACK_INDEX}"
echo "Using Flags: ${FLAGS} (Sony bootloader compatible)"

# Define all image paths
BOOT_IMAGE="${PRODUCT_OUT}/boot.img"
INIT_BOOT_IMAGE="${PRODUCT_OUT}/init_boot.img"
RECOVERY_IMAGE="${PRODUCT_OUT}/recovery.img"
VBMETA_SYSTEM_IMAGE="${PRODUCT_OUT}/vbmeta_system.img"
DTBO_IMAGE="${PRODUCT_OUT}/dtbo.img"
VENDOR_BOOT_IMAGE="${PRODUCT_OUT}/vendor_boot.img"
VENDOR_IMAGE="${PRODUCT_OUT}/vendor.img"
ODM_IMAGE="${PRODUCT_OUT}/odm.img"
SYSTEM_DLKM_IMAGE="${PRODUCT_OUT}/system_dlkm.img"
VENDOR_DLKM_IMAGE="${PRODUCT_OUT}/vendor_dlkm.img"

# Backup original
cp "${FINAL_VBMETA_IMAGE}" "${FINAL_VBMETA_IMAGE}.original"

# Rebuild vbmeta with correct structure and RIL values
${AVBTOOL} make_vbmeta_image \
    --output "${FINAL_VBMETA_IMAGE}" \
    --key "${KEY_PATH}" \
    --algorithm "${ALGORITHM}" \
    --rollback_index "${ROLLBACK_INDEX}" \
    --flags "${FLAGS}" \
    --chain_partition boot:3:"${KEY_PATH}" \
    --chain_partition init_boot:4:"${KEY_PATH}" \
    --chain_partition vendor_boot:6:"${KEY_PATH}" \
    --chain_partition recovery:1:"${KEY_PATH}" \
    --chain_partition vbmeta_system:2:"${KEY_PATH}" \
    --include_descriptors_from_image "${DTBO_IMAGE}" \
    --include_descriptors_from_image "${VENDOR_IMAGE}" \
    --include_descriptors_from_image "${ODM_IMAGE}" \
    --include_descriptors_from_image "${SYSTEM_DLKM_IMAGE}" \
    --include_descriptors_from_image "${VENDOR_DLKM_IMAGE}"

echo "✅ Custom vbmeta.img rebuilt at ${FINAL_VBMETA_IMAGE}"
echo ""
echo "🔍 Verification:"
echo "================"

# Verify RIL values are now correct
echo "Chain Partition RIL Check:"
${AVBTOOL} info_image --image ${FINAL_VBMETA_IMAGE} | grep -A2 "Chain Partition descriptor:" | grep -E "(Partition Name|Rollback Index Location)"

echo ""
echo "Partition Footer RIL Check:"
for part in boot init_boot recovery vbmeta_system; do
    echo -n "${part}: "
    ${AVBTOOL} info_image --image ${PRODUCT_OUT}/${part}.img | grep "Rollback Index Location:" | awk '{print $4}'
done

echo ""
echo "📋 Next steps:"
echo "   1. Run: ./comprehensive_size_check.sh"
echo "   2. If size mismatches exist, run: ./fix_all_size_mismatches.sh"
echo "   3. Flash and test boot"