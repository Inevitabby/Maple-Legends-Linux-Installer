step() {
	echo -e "\033[32m${1}\033[0m"
}

find_pkg_file() {
	find . -maxdepth 1 -type f -name "MapleLegends-*.pkg" | head -n 1 | xargs basename
}

reg_add() {
	wine reg add "$1" /v "$2" /t REG_SZ /d "$3" /f
}

add_dll_override() {
	cp -f "${1}.dll" ".wine/drive_c/windows/system32/"
	reg_add "HKCU\\Software\\Wine\\DllOverrides" "\"*${1}\"" "native, builtin"
}

ini_set() {
	local key="$1"
	local value="$2"
	sed -i "s|^${key} = .*|${key} = ${value}|" "MapleLegends/Legends.ini"
}

set_resolution() {
	local resolution_arr=("800x600" "1024x768" "1366x768")
	! [[ "$1" =~ ^[0-2]$ ]] && { echo "Invalid argument in set_resolution: ${1}"; exit 1; }
	reg_add "HKCU\\Software\\Wine\\Explorer\\Desktops" "Default" "${resolution_arr[$1]}"
	ini_set "HDClient" "${1}"
}
