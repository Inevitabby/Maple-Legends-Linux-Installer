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

calculate_fitted_resolution() { 
	awk -v gw="$1" -v gh="$2" -v dw="$3" -v dh="$4" 'BEGIN {
		ratio_w = dw / gw;                               # I   display_width / game_width
		ratio_h = dh / gh;                               # II  display_height / game_height
		scale = (ratio_w < ratio_h) ? ratio_w : ratio_h; # III Get ratio of the constraining side
		printf "%d %d", int(gw * scale), int(gh * scale) # IV  Multiply game resolution by ratio
	}'
}

set_virtual_desktop_resolution() {
	# 1. Get game resolution
	local width height
	local game_resolutions=("800 600" "1024 768" "1366 768")
	read -r width height <<< "${game_resolutions[$1]}"
	step "Game Resolution: $width $height"

	# 2. Get display resolution
	read -r disp_width disp_height <<< "$(xrandr 2>/dev/null | \
		grep -oE 'current [0-9]+ x [0-9]+' | \
		awk '{print $2, $4}')"
	step "Display Resolution: $disp_width $disp_height"

	# 3. Calculate fitted resolution
	if [[ -n "$disp_width" && -n "$disp_height" ]]; then
		read -r width height <<< "$(calculate_fitted_resolution "$width" "$height" "$disp_width" "$disp_height")"
		step "Fitted Resolution: $width $height"
	fi

	# 4. Apply settings
	reg_add "HKCU\\Software\\Wine\\Explorer\\Desktops" "Default" "$((width - OFFSET))x$((height - OFFSET))"
	ini_set "HDClient" "$1"
	ini_set "Windowed" "false"

	# 5. Calculate & apply DPI (pixels * 25.4 / millimeters)
	local dpi=$(xrandr --listmonitors 2>/dev/null | grep "\*" | # I   Get primary monitor
		sed 's/\// /g; s/x/ /g' |                           # II  Get resolution
		awk '{print int($3 * 25.4 / $4)}')                  # III DPI = pixels * 25.4 / millimeters
	echo "export WINE_PREFIX_DPI=${dpi:-96}" > .dpi.sh
	step "DPI: ${dpi}"
}
