#!/bin/env bash
cd "$(dirname "$0")" || exit
source .util/ensure_wine.sh

if [[ ! -d "${WINEPREFIX}" ]]; then
	echo "Please run setup.sh first (WINEPREFIX not found)"
	exit 1
fi

source .dpi.sh

wine start /unix "${WINEPREFIX}/drive_c/MapleLegends/MapleLegends.exe"
