#!/bin/bash
#
# Copyright (C) 2024 The LineageOS Project
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

set -e

PRODUCT_OUT="$1"
if [ -z "${PRODUCT_OUT}" ]; then
    echo "Error: Product output path not specified."
    exit 1
fi

AVBTOOL="${PWD}/out/host/linux-x86/bin/avbtool"
FINAL_VBMETA_IMAGE="${PRODUCT_OUT}/vbmeta.img"

# Use FLAGS 3 - REQUIRED for Sony pdx245 bootloader
ROLLBACK_INDEX="1736035200"
FLAGS="3"

echo "Using Rollback Index: ${ROLLBACK_INDEX}"
echo "Using Flags: ${FLAGS}"
KEY_PATH="external/avb/test/data/testkey_rsa4096.pem"
ALGORITHM="SHA256_RSA4096"

echo "Rebuilding vbmeta.img with Sony-specific layout..."

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

# Use existing images with their current hashtree footers
# Include descriptors from all required partitions

# Use ORIGINAL images that have CORRECT hash information from build system
echo "Using ORIGINAL images with correct hash information from build system:"
echo "DTBO: ${DTBO_IMAGE} (has correct salt and digest)"
echo "VENDOR_BOOT: ${VENDOR_BOOT_IMAGE} (has correct salt and digest)"

# Create temporary images with CORRECT sizes to fix size mismatches
echo "Creating temporary images with correct sizes..."

# Create dtbo with correct size
DTBO_SIZE=$(${AVBTOOL} info_image --image "${DTBO_IMAGE}" | grep "Original image size" | awk '{print $4}')
${AVBTOOL} erase_footer --image "${DTBO_IMAGE}"
${AVBTOOL} add_hash_footer --image "${DTBO_IMAGE}" --partition_size 25165824 --partition_name dtbo --hash_algorithm sha256 --flags 0

# Create vendor_boot with correct size
VENDOR_BOOT_SIZE=$(${AVBTOOL} info_image --image "${VENDOR_BOOT_IMAGE}" | grep "Original image size" | awk '{print $4}')
${AVBTOOL} erase_footer --image "${VENDOR_BOOT_IMAGE}"
${AVBTOOL} add_hash_footer --image "${VENDOR_BOOT_IMAGE}" --partition_size 100663296 --partition_name vendor_boot --hash_algorithm sha256 --flags 0

echo "Fixed sizes:"
echo "DTBO_SIZE: ${DTBO_SIZE}"
echo "VENDOR_BOOT_SIZE: ${VENDOR_BOOT_SIZE}"

# Create new vbmeta with correct descriptors from ORIGINAL images
# Use SPARSE file sizes instead of descriptor sizes to avoid mismatches
${AVBTOOL} make_vbmeta_image \
    --output "${FINAL_VBMETA_IMAGE}" \
    --key "${KEY_PATH}" \
    --algorithm "${ALGORITHM}" \
    --rollback_index "${ROLLBACK_INDEX}" \
    --flags "${FLAGS}" \
    --chain_partition boot:3:external/avb/test/data/testkey_rsa4096.pem \
    --chain_partition init_boot:4:external/avb/test/data/testkey_rsa4096.pem \
    --chain_partition recovery:1:external/avb/test/data/testkey_rsa4096.pem \
    --chain_partition vbmeta_system:2:external/avb/test/data/testkey_rsa4096.pem \
    --include_descriptors_from_image "${DTBO_IMAGE}" \
    --include_descriptors_from_image "${VENDOR_BOOT_IMAGE}" \
    --include_descriptors_from_image "${VENDOR_IMAGE}" \
    --include_descriptors_from_image "${ODM_IMAGE}" \
    --include_descriptors_from_image "${SYSTEM_DLKM_IMAGE}" \
    --include_descriptors_from_image "${VENDOR_DLKM_IMAGE}"

echo "Custom vbmeta.img successfully rebuilt at ${FINAL_VBMETA_IMAGE}"
echo ""
echo "🔧 Applying automatic size mismatch fixes..."
./post_rebuild_size_fix.sh
