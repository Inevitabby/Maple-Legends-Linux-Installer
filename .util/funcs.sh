# Logging

step() {
	echo -e "\033[32m${1}\033[0m"
}

# Pkg

find_pkg() {
	find . -maxdepth 1 -type f -name "MapleLegends-*.pkg" | head -n 1 | xargs basename
}

# Registry 

reg_add() {
	wine reg add "$1" /v "$2" /t REG_SZ /d "$3" /f
}
add_dll_override() {
	cp -f "./.dlls/${1}.dll" ".wine/drive_c/windows/system32/"
	reg_add "HKCU\\Software\\Wine\\DllOverrides" "\"*$1\"" "native, builtin"
}

# Ini

ini_set() {
	local key="$1"
	local value="$2"
	sed -i "s|^${key} = .*|${key} = ${value}|" "MapleLegends/Legends.ini"
}

# Virtual Desktop

set_virtual_desktop_resolution() {
	# 1. Set resolution to match display
	local width height
	read -r width height <<< "$(xrandr 2>/dev/null | grep -oE 'current [0-9]+ x [0-9]+' | awk '{print $2, $4}')"
	# Fallback: Use game resolution if xrandr failed
	if [[ -z "$width" ]]; then
		local game_resolutions=("800 600" "1024 768" "1366 768")
		read -r width height <<< "${game_resolutions[$1]}"
	fi
	step "Virtual Desktop Resolution: $width $height"

	# 2. Apply settings
	reg_add "HKCU\\Software\\Wine\\Explorer\\Desktops" "Default" "${width}x${height}"
	ini_set "HDClient" "$1"
	ini_set "Windowed" "false"

	# 3. Calculate DPI (pixels * 25.4 / millimeters)
	local dpi=$(xrandr --listmonitors 2>/dev/null | grep "\*" | # I   Get primary monitor
		sed 's/\// /g; s/x/ /g' |                           # II  Get resolution
		awk '{print int($3 * 25.4 / $4)}')                  # III DPI = pixels * 25.4 / millimeters
	echo "export WINE_PREFIX_DPI=${dpi:-96}" > .dpi.sh
	step "DPI: ${dpi}"
}
