#!/bin/bash

# Script to fix XML tag names in VINTF configuration files
# Changes <n> tags to <name> tags

find "$(dirname "$0")" -type f -name "*.xml" -exec sed -i 's/<n>/<name>/g; s/<\/n>/<\/name>/g' {} \;

echo "Fixed XML tags in all VINTF files" 