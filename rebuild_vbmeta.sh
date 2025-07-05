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

# This script is called manually after a build to fix a flaw in the AOSP
# build system where it fails to correctly propagate flags from partition
# footers into the main vbmeta.img chain descriptors.

set -e

# The product out directory is the first argument
PRODUCT_OUT="$1"
if [ -z "${PRODUCT_OUT}" ]; then
    echo "Error: Product output path not specified."
    exit 1
fi

# Use absolute path for AVBTOOL to ensure it's found
AVBTOOL="${PWD}/out/host/linux-x86/bin/avbtool"
FINAL_VBMETA_IMAGE="${PRODUCT_OUT}/vbmeta.img"

# We will use the rollback index from the build-generated vbmeta.img,
# but we will explicitly set the flags to 3 to match our configuration.
ROLLBACK_INDEX=$(${AVBTOOL} info_image --image ${FINAL_VBMETA_IMAGE} | grep "Rollback Index:" | awk '{print $3}')
FLAGS=3 # This is the critical fix.

KEY_PATH="external/avb/test/data/testkey_rsa4096.pem"
ALGORITHM="SHA256_RSA4096"

echo "Rebuilding vbmeta.img with correct chain partition flags..."
echo "Using Rollback Index: ${ROLLBACK_INDEX}"
echo "Using Flags: ${FLAGS}"

BOOT_IMAGE="${PRODUCT_OUT}/boot.img"
INIT_BOOT_IMAGE="${PRODUCT_OUT}/init_boot.img"
RECOVERY_IMAGE="${PRODUCT_OUT}/recovery.img"
VBMETA_SYSTEM_IMAGE="${PRODUCT_OUT}/vbmeta_system.img"
DTBO_IMAGE="${PRODUCT_OUT}/dtbo.img"
VENDOR_BOOT_IMAGE="${PRODUCT_OUT}/vendor_boot.img"

# Construct the final avbtool command.
# By *not* including hashtree descriptors from logical partitions, we are creating
# a standard AOSP vbmeta.img. The only purpose of this script is to fix the
# incorrect flags in the chain partition descriptors.
${AVBTOOL} make_vbmeta_image \
    --output "${FINAL_VBMETA_IMAGE}" \
    --key "${KEY_PATH}" \
    --algorithm "${ALGORITHM}" \
    --rollback_index "${ROLLBACK_INDEX}" \
    --flags "${FLAGS}" \
    --chain_partition boot:3:"${KEY_PATH}" \
    --chain_partition init_boot:4:"${KEY_PATH}" \
    --chain_partition recovery:1:"${KEY_PATH}" \
    --chain_partition vbmeta_system:2:"${KEY_PATH}" \
    --include_descriptors_from_image "${DTBO_IMAGE}" \
    --include_descriptors_from_image "${VENDOR_BOOT_IMAGE}"

echo "Custom vbmeta.img successfully rebuilt at ${FINAL_VBMETA_IMAGE}" 