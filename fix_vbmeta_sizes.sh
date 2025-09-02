#!/bin/bash
# fix_vbmeta_sizes.sh – regenerate vbmeta.img after build so that
# hash-descriptor “Image Size” fields for dtbo and vendor_boot match
# the final images. Works with avbtool 1.3.0 (no --hash_image).
# Usage: ./fix_vbmeta_sizes.sh <product_out_dir>
set -e

PRODUCT_OUT="$1"
if [ -z "$PRODUCT_OUT" ] || [ ! -d "$PRODUCT_OUT" ]; then
  echo "Usage: $0 <product_out_dir>" >&2
  exit 1
fi

# tools & constants
AVB=out/host/linux-x86/bin/avbtool
KEY=external/avb/test/data/testkey_rsa4096.pem
ROLLBACK=1736035200   # or use $(date +%s)

# ensure dtbo / vendor_boot have unsigned hash footers sized to original payload
fix_footer() {
  local img=$1; local partname=$2
  if [ ! -f "$img" ]; then return; fi
  # erase any existing footer silently
  $AVB erase_footer --image "$img" 2>/dev/null || true
  local orig size align
  # Use Original image size if footer exists, else file size
  orig=$($AVB info_image --image "$img" 2>/dev/null | grep "Original image size" | awk '{print $4}')
  if [ -z "$orig" ]; then
    orig=$(stat -c%s "$img")
  fi
  # To make descriptor = original, set partition_size = original + footer_slack + alignment
  local footer_slack=131072  # 128KB
  local temp=$(( orig + footer_slack ))
  align=$(( (temp + 4095) / 4096 * 4096 ))
  echo "[$partname] add footer: orig=$orig temp=$temp aligned_part=$align"
  $AVB add_hash_footer --image "$img" \
                      --partition_size $align \
                      --partition_name $partname \
                      --algorithm NONE --hash_algorithm sha256
}

echo "[pdx245] Ensuring footers on dtbo/vendor_boot..."
fix_footer "$PRODUCT_OUT/dtbo.img" dtbo
[ -f "$PRODUCT_OUT/vendor_boot.img" ] && fix_footer "$PRODUCT_OUT/vendor_boot.img" vendor_boot

echo "[pdx245] Rebuilding vbmeta.img with fresh descriptors..."

CMD=("$AVB" make_vbmeta_image \
      --output "$PRODUCT_OUT/vbmeta.img" \
      --key "$KEY" \
      --algorithm SHA256_RSA4096 \
      --flags 3 \
      --rollback_index "$ROLLBACK" \
      --include_descriptors_from_image "$PRODUCT_OUT/dtbo.img")

[ -f "$PRODUCT_OUT/vendor_boot.img" ] && CMD+=(--include_descriptors_from_image "$PRODUCT_OUT/vendor_boot.img")

CMD+=(--chain_partition boot:3:"$KEY" \
      --chain_partition init_boot:4:"$KEY" \
      --chain_partition recovery:1:"$KEY" \
      --chain_partition vbmeta_system:2:"$KEY")

"${CMD[@]}"

echo "[pdx245] vbmeta.img regenerated ✔"
