#!/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2025 Roman Koch <koch.romam@gmail.com>

# ATTENTION: DEMO ONLY

IMAGES_DIR="deploy-ti/images/beaglebone/" # Pfad zu den Yocto-Images
OUTPUT_DIR="sd-card/" # Zielordner für entpackte Dateien

if [ ! -d "$IMAGES_DIR" ]; then
  echo "FEHLER: Der Quellordner $IMAGES_DIR existiert nicht."
  exit 1
fi

if [ -d "$OUTPUT_DIR" ]; then
  echo "$OUTPUT_DIR directory exists: remove"
  rm -rf "$OUTPUT_DIR"
fi

echo "create target directory: $OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

echo "copy .wic.xz und .bmap files..."
#cp "$IMAGES_DIR"/*.wic.xz "$OUTPUT_DIR" 2>/dev/null
#cp "$IMAGES_DIR"/*.bmap "$OUTPUT_DIR" 2>/dev/null
find "$IMAGES_DIR" -type f -name "*.wic.xz" -exec cp -P {} "$OUTPUT_DIR" \;
find "$IMAGES_DIR" -type f -name "*.bmap" -exec cp -P {} "$OUTPUT_DIR" \;

echo "extract .wic.xz files..."
for file in "$OUTPUT_DIR"/*.wic.xz; do
  if [ -f "$file" ]; then
    echo "file $file..."
    xz -d "$file"
  else
    echo "no one .wic.xz file found."
  fi
done

echo "done. Target directory: $OUTPUT_DIR."

