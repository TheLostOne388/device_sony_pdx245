#!/bin/bash

# Path to the vendor manifest
MANIFEST_PATH="$1"

if [ ! -f "$MANIFEST_PATH" ]; then
    echo "Manifest file not found at $MANIFEST_PATH - will be processed later"
    exit 0
fi

# Add the 'level' attribute to the manifest tag
sed -i 's/<manifest version="8.0" type="device">/<manifest version="8.0" type="device" level="15">/' "$MANIFEST_PATH"
echo "Added FCM level 15 to $MANIFEST_PATH"