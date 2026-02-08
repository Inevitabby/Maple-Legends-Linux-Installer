# Using Kron4ek's builds: https://github.com/Kron4ek/Wine-Builds/releases
WINE_URL="https://github.com/Kron4ek/Wine-Builds/releases/download/11.1/wine-11.1-staging-x86.tar.xz"
WINE_SHA256="ad9faa4dbb077e0dc2f7992b48824114ca736e66b97411c53845a9bdde4e6136"

WINE_DIR="$(pwd)/.wine-bin"
WINE_TAR="$(pwd)/$(basename "$WINE_URL")"

if [[ ! -f "$WINE_DIR/bin/wine" ]]; then
    step "Preparing wine..."
    mkdir -p "$WINE_DIR"
    # Special: Download wine if missing
    [[ ! -f "$WINE_TAR" ]] && curl -L "$WINE_URL" -o "$WINE_TAR"
    # Check checksum
    echo "$WINE_SHA256  $WINE_TAR" | sha256sum -c - || {
        echo "Checksum failed! The file may be corrupted."
        rm "$WINE_TAR"
        exit 1
    }
    # Extract files
    tar -xJ -f "$WINE_TAR" -C "$WINE_DIR" --strip-components=1
fi

# Export environment variables
export PATH="$WINE_DIR/bin:$PATH"
export WINEARCH="win32"
export WINEPREFIX="$(realpath .wine)"

