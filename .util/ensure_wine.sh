# Using Kron4ek's builds: https://github.com/Kron4ek/Wine-Builds/releases
WINE_URL="https://github.com/Kron4ek/Wine-Builds/releases/download/11.1/wine-11.1-staging-x86.tar.xz"
WINE_DIR="$(pwd)/.wine-bin"

# Download wine if missing
if [[ ! -f "$WINE_DIR/bin/wine" ]]; then
    echo "Downloading Wine Staging (x86)..."
    mkdir -p "$WINE_DIR"
    curl -L "$WINE_URL" | tar -xJ -C "$WINE_DIR" --strip-components=1
fi

# Export environment  variables
export PATH="$WINE_DIR/bin:$PATH"
export WINEARCH="win32"
export WINEPREFIX="$(realpath .wine)"
