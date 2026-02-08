# Check for user-supplied files
if [[ ! -f "ws2help.dll" || ! -f "ws2_32.dll" ]]; then
	echo "Error: Required DLLs not found in project directory."
	echo "Make sure 'ws2help.dll' and 'ws2_32.dll' are present before continuing (see README)."
	exit 1
fi
if [[ -z "${PKG}" ]]; then
	echo "Error: MapleLegends-*.pkg not found in project directory."
	echo "Make sure the latest Maple Legends Mac Winescope .pkg is present before continuing (see README)."
	exit 1

fi
echo
# Ask if the user wants to do a reinstall
if [ -d "MapleLegends" ]; then
	read -p $'\033[31mPrevious install found, do you want to reinstall everything? (this will delete ".wine", ".wine-bin", and "MapleStory") [y/n] \033[0m' -n 1 -r
	echo
	[[ ! $REPLY =~ ^[Yy]$ ]] && exit 1
	rm -rf ".wine" "MapleLegends" ".wine-bin"
fi
