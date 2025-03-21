#!/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2025 Roman Koch <koch.romam@gmail.com>

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path/to/image.wic> <TARGET-IP>"
    nmap -sn 192.168.0.0/24
    exit 1
fi

IMAGE_PATH=sd-card/
FILENAME=`ls ${IMAGE_PATH}/*.wic`

echo "image ${FILENAME}"

BBB_IP=$1

if [[ ! -f "$FILENAME" ]]; then
    echo "error: image-file $IMAGE_PATH not found."
    exit 1
fi

echo "the image $FILENAME should be flashed on target with IP $BBB_IP"
read -p "Confirm? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
    echo "Abbruch."
    exit 0
fi

echo "write..."
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@"$BBB_IP" "dd of=/dev/mmcblk1 bs=4M" < "$FILENAME"

if [ $? -eq 0 ]; then
    echo "success"
else
    echo "error: flash mission failed."
    exit 1
fi
