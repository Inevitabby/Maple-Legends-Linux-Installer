#!/bin/env bash
cd "$(dirname "$0")" || exit

export WINEPREFIX="$(realpath .wine)"
[[ -d "${WINEPREFIX}" ]] || { echo "Please run setup.sh first (WINEPREFIX not found)"; exit 1; }

source .util/ensure_wine.sh
source .dpi.sh

wine start /unix "${WINEPREFIX}/drive_c/MapleLegends/MapleLegends.exe"
