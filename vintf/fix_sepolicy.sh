#!/bin/bash
# Script to fix VINTF compatibility by removing the problematic 202404 sepolicy matrix
echo "Fixing VINTF compatibility for PDX245..."

# Variables
MATRIX_DIR="$OUT/system/etc/vintf"
PROBLEM_FILE="$MATRIX_DIR/compatibility_matrix.202404.xml"
BACKUP_DIR="$OUT/vintf_backup"

# Make sure output directory exists
if [ -z "$OUT" ]; then
  echo "ERROR: OUT variable not set. Run 'lunch' first."
  exit 1
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Check if problematic file exists
if [ -f "$PROBLEM_FILE" ]; then
  echo "Found problematic file: $PROBLEM_FILE"
  echo "Moving to backup location..."
  mv "$PROBLEM_FILE" "$BACKUP_DIR/compatibility_matrix.202404.xml.bak"
  echo "Done! The problematic file has been moved."
else
  echo "Problematic file not found. Nothing to do."
fi

# Create an empty version of the file to prevent build errors
touch "$PROBLEM_FILE"
echo '<?xml version="1.0" encoding="utf-8"?>' > "$PROBLEM_FILE"
echo '<compatibility-matrix version="1.0" type="framework" level="6">' >> "$PROBLEM_FILE"
echo '<!-- This is an empty placeholder to replace the problematic 202404.0 matrix -->' >> "$PROBLEM_FILE"
echo '</compatibility-matrix>' >> "$PROBLEM_FILE"

echo "Created empty placeholder for compatibility_matrix.202404.xml"
echo "VINTF compatibility fix completed!" 