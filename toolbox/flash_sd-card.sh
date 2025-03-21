#!/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2025 Roman Koch <koch.romam@gmail.com>

set -e  # Stop on error

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <sd_card>"
    exit 1
fi

IMAGE_DIR=sd-card/
IMAGE_PATH=`ls ${IMAGE_DIR}/*.wic`

echo "image ${IMAGE_PATH}"

SD_CARD=$1

if [[ $EUID -ne 0 ]]; then
   echo "call script with sudo or as root."
   exit 1
fi

if [[ ! -f "$IMAGE_PATH" ]]; then
    echo "error: image-file $IMAGE_PATH not foound."
    exit 1
fi

echo "WARNUNG: all the fiels on $SD_CARD should be removed!"
echo "format? (yes/no)"
read -r CONFIRMATION

if [[ "$CONFIRMATION" != "yes" ]]; then
    echo "cancel."
    exit 0
fi

umount ${SD_CARD}* 2>/dev/null || true

echo "write image on $SD_CARD ..."
dd if="$IMAGE_PATH" of="$SD_CARD" bs=4M status=progress
sync

echo "done. remove SD-card."
