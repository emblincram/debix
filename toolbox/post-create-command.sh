#!/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2025 Roman Koch <koch.romam@gmail.com>

source "$(dirname "$0")/utilities.sh"

# parameter

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

WORKSPACE_PATH=$1

LAYER_DIRECTORY=${WORKSPACE_PATH}

# yocto layer for beagle-x15
clone_and_checkout "https://git.yoctoproject.org/poky"     "${WORKSPACE_PATH}/poky" "scarthgap" 1
clone_and_checkout "https://git.yoctoproject.org/meta-arm" "${WORKSPACE_PATH}/meta-arm" "scarthgap" 1
clone_and_checkout "https://github.com/openembedded/meta-openembedded.git" "${WORKSPACE_PATH}/meta-openembedded" "scarthgap" 1

#clone_and_checkout "https://git.yoctoproject.org/meta-ti" "${WORKSPACE_PATH}/meta-ti" "scarthgap" 1

clone_and_checkout "https://github.com/Freescale/meta-freescale.git"          "${WORKSPACE_PATH}/meta-frescale" "scarthgap" 1
clone_and_checkout "https://github.com/Freescale/meta-freescale-3rdparty.git" "${WORKSPACE_PATH}/meta-freescale-3rdparty" "scarthgap" 1
clone_and_checkout "https://github.com/Freescale/meta-freescale-distro.git"   "${WORKSPACE_PATH}//meta-freescale-distro" "scarthgap" 1


GITHUB_TOKEN=$CR_PAT

if [ -z "$GITHUB_TOKEN" ]; then
    echo "ERROR: GITHUB_TOKEN not set"
    exit 1
fi

# Project meta-layer
clone_and_checkout "https://${GITHUB_TOKEN}@github.com/emblincram/meta-emblincram.git" "${WORKSPACE_PATH}/meta-emblincram" "main"

# meta-pq-box applications
create_directory "${WORKSPACE_PATH}/app"
clone_and_checkout "https://${GITHUB_TOKEN}@github.com/emblincram/distrap.git" "${WORKSPACE_PATH}/app/distrap" "main"
clone_and_checkout "https://${GITHUB_TOKEN}@github.com/emblincram/heartbeat.git" "${WORKSPACE_PATH}/app/heartbeat" "main"
clone_and_checkout "https://${GITHUB_TOKEN}@github.com/emblincram/helloly.git" "${WORKSPACE_PATH}/app/helloly" "main"
clone_and_checkout "https://${GITHUB_TOKEN}@github.com/emblincram/streamer.git" "${WORKSPACE_PATH}/app/streamer" "main"

echo "copy toolbox functions"
create_directory ${LAYER_DIRECTORY}/build
create_directory ${LAYER_DIRECTORY}/toolbox
${LAYER_DIRECTORY}/toolbox/copy-tools.sh ${LAYER_DIRECTORY}/toolbox ${LAYER_DIRECTORY}/build 

echo "copy environment activation script"
cp ${LAYER_DIRECTORY}/toolbox/activate-env.sh ${LAYER_DIRECTORY}/

echo 'dev-container created.'

