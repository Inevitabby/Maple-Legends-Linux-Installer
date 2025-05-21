#!/bin/env bash
cd "$(dirname "$0")" || exit

export WINEPREFIX="$(realpath .wine)"
export WINEARCH="win32"

if [[ ! -d "${WINEPREFIX}" ]]; then
	echo "Please run setup.sh first (WINEPREFIX not found)"
	exit 1
fi

wine start /unix "${WINEPREFIX}/drive_c/MapleLegends/MapleLegends.exe"
