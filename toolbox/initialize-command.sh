#!/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2025 Roman Koch <koch.romam@gmail.com>

source "$(dirname "$0")/utilities.sh"

# parameter

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <pfad>"
    exit 1
fi

WORKSPACE_PATH=$1

source ~/.bashrc

create_directory "${WORKSPACE_PATH}/../../downloads"
create_directory "${WORKSPACE_PATH}/../../sstate-cache"
create_directory "${WORKSPACE_PATH}/build"

export YOCTO_SSTATE_DIR="${WORKSPACE_PATH}/../../downloads"
export YOCTO_DL_DIR="${WORKSPACE_PATH}/../../sstate-cache"
