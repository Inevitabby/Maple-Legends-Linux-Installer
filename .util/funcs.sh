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
	local game_w=$1 game_h=$2 disp_w=$3 disp_h=$4
	local scale_factor=$(echo "scale=10; \
		w_scale=${disp_w}/${game_w}; \
		h_scale=${disp_h}/${game_h}; \
		if (w_scale < h_scale) { w_scale } else { h_scale }" | bc)
	local scaled_w=$(echo "${game_w} * ${scale_factor} / 1" | bc)
	local scaled_h=$(echo "${game_h} * ${scale_factor} / 1" | bc)
	local dpi=$(echo "${scale_factor} * 96" | bc)
	echo "${scale_factor} ${scaled_w} ${scaled_h} ${dpi}"
}

apply_wine_dpi() {
	echo "export WINE_PREFIX_DPI=$1" > .dpi.sh
}


get_game_resolution() {
	local resolution_arr_x=("800" "1024" "1366")
	local resolution_arr_y=("600" "768" "768")
	echo "${resolution_arr_x[$1]} ${resolution_arr_y[$1]}"
}

get_display_resolution() {
	command -v xrandr >/dev/null 2>&1 || { echo "0 0"; return; }
	xrandr --query | awk '/ connected primary/ {print $4}' | cut -d '+' -f1 | awk -Fx '{print $1, $2}'
}

set_resolution() {
	! [[ "$1" =~ ^[0-2]$ ]] && { echo "Invalid argument in set_resolution: $1"; exit 1; }
	read -r game_w game_h <<< "$(get_game_resolution "$1")"
	read -r disp_w disp_h <<< "$(get_display_resolution)"
	local virt_w=$game_w virt_h=$game_h
	if [[ $disp_w -gt 0 && $disp_h -gt 0 ]]; then
		read -r scale_factor virt_w virt_h dpi <<< "$(calculate_fitted_resolution "${game_w}" "${game_h}" "${disp_w}" "${disp_h}")"
		apply_wine_dpi "$dpi"
	else
		echo "(xrandr not found, falling back to defaults)"
	fi
	reg_add "HKCU\\Software\\Wine\\Explorer\\Desktops" "Default" "${virt_w}x${virt_h}"
	ini_set "HDClient" "$1"
	ini_set "Windowed" "false"
	integer_scaled_dpi "${game_w}" "${game_h}"
}
