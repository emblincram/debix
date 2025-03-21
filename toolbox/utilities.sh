#!/bin/bash

# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2024 Roman Koch <koch.romam@gmail.com>

create_directory() {
    local repo_dir=$1
    if [ ! -d "$repo_dir" ]; then
        echo "create ${repo_dir}..."
        mkdir -p ${repo_dir}
    fi
}

clone_and_checkout() {
    set -eo pipefail

    local repo_url=$1
    local repo_dir=$2
    local branch=$3
    local depth=$4

    local depth_param=""
    if [ -n "$depth" ]; then
        depth_param="--depth=$depth"
    fi

    local original_dir="$(pwd)"

    if [ -d "$repo_dir" ]; then
        if [ -d "$repo_dir/.git" ]; then
            echo "Repository $repo_dir existiert bereits und ist ein Git-Repository."
            cd "$repo_dir"
            git fetch origin

            # repository flip back
            # git reset --hard origin/"$branch"

            git checkout "$branch"
            git pull origin "$branch"
            cd "$original_dir"
        else
            echo "Verzeichnis $repo_dir existiert, ist aber kein Git-Repository. Lösche und klone neu."
            rm -rf "$repo_dir"
            git clone --branch "$branch" $depth_param "$repo_url" "$repo_dir"
        fi
    else
        echo "Klonen von $repo_url nach $repo_dir..."
        git clone --branch "$branch" $depth_param "$repo_url" "$repo_dir"
    fi

    cd "$original_dir"
}

check_and_link_or_create() {
    local env_var_name=$1
    local target_name=$2
    local default_dir="${WORKSPACE_PATH}/${target_name}"
    local target_dir="${!env_var_name}"

    if [ -z "$target_dir" ]; then
        echo "warning: $env_var_name not set. create directory: $default_dir"
        mkdir -p "$default_dir"
    else
        echo "$env_var_name gesetzt: $target_dir"
        mkdir -p "$target_dir"
        ln -sfn "$target_dir" "${WORKSPACE_PATH}/${target_name}"
        echo "symlink creted: ${WORKSPACE_PATH}/${target_name} -> $target_dir"
    fi
}

# Funktion zur Sicherung des Verzeichnisses mit Zeitstempel-Erweiterung
backup_existing_dir() {
    local dir="$1"
    if [ -d "$dir" ]; then
        local timestamp=$(date +"%Y%m%d_%H%M%S")
        local backup_dir="${dir}.${timestamp}"
        mv "$dir" "$backup_dir"
        echo "backup current directory: $backup_dir"
    fi
}

