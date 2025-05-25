#!/bin/env bash
cd "$(dirname "$0")" || exit
source .util/funcs.sh

export WINEARCH="win32"
export WINEPREFIX=$(realpath ".wine")
readonly PKG=$(find_pkg_file)
readonly RES="1" # 0 = 800x600, 1 = 1024x768, 2 = 1366x768 (potentially unstable)

source .util/setup_checks.sh

step "1. Extract game files from ${PKG} [1/7]"
bsdtar -xO --fast-read --file "$PKG" "MapleLegends.pkg/Payload" | \
	bsdtar -xv --strip-components=5 "MapleLegends.app/Contents/Resources/drive_c/MapleLegends"

step "2. Create 32-bit Wine prefix [2/7]"
wineboot --init
wineserver -w

step "3. Install Corefonts [3/7]"
winetricks -q corefonts # vcrun6sp6 dxvk vkd3d

step "4. Installing networking DLLs [4/7]"
add_dll_override "ws2help"
add_dll_override "ws2_32"

step "5. Setting Virtual Desktop and WINE_DPI_SCALE [5/7]"
reg_add "HKCU\\Software\\Wine\\Explorer" "Desktop" "Default"
set_resolution "${RES}"

step "6. Setting Windows Version [6/7]"
winetricks -q win98

step "7. Linking MapleLegends folder to Wineprefix [7/7]"
ln -s "$(realpath "MapleLegends")" "${WINEPREFIX}/drive_c/MapleLegends"
ini_set "SkipLogoAnimation" "true"

step "Game is ready! Launch with ./play.sh"
wait
wineserver -k
