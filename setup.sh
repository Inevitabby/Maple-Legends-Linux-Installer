#!/bin/env bash
cd "$(dirname "$0")" || exit
source .util/funcs.sh

readonly PKG=$(find_pkg)
readonly RES="1" # 0 = 800x600, 1 = 1024x768, 2 = 1366x768 (unstable!!!)

source .util/setup_checks.sh
source .util/setup_wine.sh

step "1. Extracting game files from ${PKG} (this may take a while)... [1/6]"
bsdtar -xO --fast-read --file "$PKG" "MapleLegends.pkg/Payload" | \
	bsdtar -x --strip-components=5 "MapleLegends.app/Contents/Resources/drive_c/MapleLegends"

step "2. Creating 32-bit Wine prefix... [2/6]"
wineboot --init
wineserver -w

step "3. Installing networking DLLs... [3/6]"
add_dll_override "ws2help"
add_dll_override "ws2_32"

step "4. Setting Virtual Desktop and WINE_DPI_SCALE... [4/6]"
reg_add "HKCU\\Software\\Wine\\Explorer" "Desktop" "Default"
set_virtual_desktop_resolution "${RES}"

step "5. Setting Windows Version... [5/6]"
reg_add "HKCU\\Software\\Wine" "Version" "win98"

step "6. Linking MapleLegends folder to Wineprefix [6/6]"
ln -s "$(realpath "MapleLegends")" "${WINEPREFIX}/drive_c/MapleLegends"
ini_set "SkipLogoAnimation" "true"

step "Game is ready! Launch with ./play.sh"
wait
wineserver -k
