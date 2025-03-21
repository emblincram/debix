#!/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2024 Roman Koch <koch.romam@gmail.com>

# Attention: works proper only in build directory

CONFIG_BACKUP_DIR="project.config.backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p "$CONFIG_BACKUP_DIR"
cp conf/local.conf "$CONFIG_BACKUP_DIR/local.conf_$TIMESTAMP"
cp conf/bblayers.conf "$CONFIG_BACKUP_DIR/bblayers.conf_$TIMESTAMP"

echo "Configs gesichert nach $CONFIG_BACKUP_DIR"
