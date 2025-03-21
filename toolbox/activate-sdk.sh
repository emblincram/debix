#/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2024 Roman Koch <koch.romam@gmail.com>

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo ${BASE_DIR}
TARGET_DIR="${BASE_DIR}/../sdk/"

ENV_FILE=$(find "$TARGET_DIR" -type f -name "environment-setup-*" | head -n 1)

if [ -z "$ENV_FILE" ]; then
    echo "error: no proper ENV-file found."
    exit 1
fi

source "${ENV_FILE}"

