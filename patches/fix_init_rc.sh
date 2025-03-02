#!/bin/bash

# Path to the init script
INIT_RC="vendor/lineage/prebuilt/common/etc/init/init.lineage-system_ext.rc"

# Create temp file
TMP_FILE=$(mktemp)

# Add user and group to bugreport service
sed '/service bugreport/a\    user shell\n    group system shell log' "$INIT_RC" > "$TMP_FILE"

# Copy back
cp "$TMP_FILE" "$INIT_RC"
rm "$TMP_FILE"