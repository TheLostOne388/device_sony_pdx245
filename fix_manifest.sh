#!/bin/bash

MANIFEST_DIR="$OUT_DIR/target/product/pdx245/vendor/etc/vintf"

if [ ! -d "$MANIFEST_DIR" ]; then
  echo "Manifest directory not found at $MANIFEST_DIR"
  exit 1
fi

MANIFEST_PATH="$MANIFEST_DIR/manifest.xml"

if [ ! -f "$MANIFEST_PATH" ]; then
  echo "Manifest file not found at $MANIFEST_PATH"
  exit 1
fi

# Apply patch or do direct sed replacement
if grep -q 'level="15"' "$MANIFEST_PATH"; then
  echo "FCM level already set to 15"
else
  echo "Adding FCM level 15 to manifest"
  sed -i 's/<manifest version="8.0" type="device">/<manifest version="8.0" type="device" level="15">/' "$MANIFEST_PATH"
  echo "Done!"
fi

# Verify the change
if grep -q 'level="15"' "$MANIFEST_PATH"; then
  echo "Verified: FCM level set to 15"
else
  echo "ERROR: Failed to set FCM level to 15"
  exit 1
fi