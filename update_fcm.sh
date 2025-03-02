#!/bin/bash

# This script can be run manually to update the FCM level in the VINTF manifest
# Usage: ./update_fcm.sh [path/to/manifest.xml]

# Default manifest location if not provided
MANIFEST_FILE="${1:-$ANDROID_BUILD_TOP/out/target/product/pdx245/vendor/etc/vintf/manifest.xml}"

if [ ! -f "$MANIFEST_FILE" ]; then
    echo "Error: Manifest file not found at $MANIFEST_FILE"
    exit 1
fi

# Make a backup
cp "$MANIFEST_FILE" "$MANIFEST_FILE.bak"

# Add FCM level if not already present
if grep -q 'level="15"' "$MANIFEST_FILE"; then
    echo "FCM level already present in manifest"
else
    echo "Adding FCM level 15 to VINTF manifest"
    sed -i 's/<manifest version="[0-9.]*" type="device"/<manifest version="8.0" type="device" level="15"/' "$MANIFEST_FILE"
    
    # Verify the change
    if grep -q 'level="15"' "$MANIFEST_FILE"; then
        echo "Successfully added FCM level 15 to VINTF manifest"
    else
        echo "Failed to add FCM level to manifest"
        # Restore backup
        mv "$MANIFEST_FILE.bak" "$MANIFEST_FILE"
        exit 1
    fi
fi

# Remove backup if successful
rm -f "$MANIFEST_FILE.bak"