#!/bin/env bash
cd "$(dirname "$0")" || exit

if [[ ! -d ".wine" || ! -d "MapleLegends" ]]; then
    echo "Please run setup.sh first (.wine or MapleLegends directory not found)"
    exit 1
fi

source .util/setup_wine.sh

wine start /unix "${WINEPREFIX}/drive_c/MapleLegends/MapleLegends.exe"
