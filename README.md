<div align="center">
	<h1>Maple Legends Linux Installer</h1>
</div>

# Requirements

**Software**:
- Wine with 32-bit support
- Winetricks
- bsdtar
- xrandr (optional, for calculating optimal scale)

**User Responsibilities**:
- Place the latest Mac Wineskin `.pkg` for Maple Legends in the root directory of this project _(see [Instructions](#instructions))_.
- Place `ws2_32.dll` and `ws2help.dll` in the root directory of this project _(see [Instructions](#instructions))_.
- Possess a valid Windows license to use the Microsoft DLLs.

# Instructions

```bash
git clone https://github.com/inevitabby/maple-legends-linux-installer
cd maple-legends-linux-installer
# (add DLLs and pkg to project root here)
./setup.sh
./play.sh
```

## 1. **Download Networking DLLs**

**Why**: We need to replace Wine's built-in stubs for `ws2_32.dll` and `ws2help.dll` with Microsoft's version.
- **How**: Place the DLLs in the root directory of this project.

> [!NOTE]  
> For your convenience, you can download the DLLs from the following unofficial mirrors. By running these two curl commands (in the root directory of this project), you confirm you possess a valid Windows license and accept responsibility for downloading Microsoft DLLs from unofficial sources:
> 
> ```bash
> curl -L -o ws2_32.dll https://files.catbox.moe/4k3063.dll
> curl -L -o ws2help.dll https://files.catbox.moe/ml5pe6.dll
> ```

## 2. **Download the Latest Mac Wineskin**

**Why**: We use the Mac Wineskin release for our game files.
- **How**: Download the Mac **Wineskin** `.pkg` for Maple Legends (**not Crossover**) from [maplelegends.com/download](https://maplelegends.com/download)
  - Place the `.pkg` in the root directory of this project.

> [!TIP]
> The Mac Wineskin download is several clicks deep from the main page. For a slightly faster route, check the latest announcements in the [Maple Legends forums](https://forum.maplelegends.com/index.php?forums/announcements/).

# Helpful Tidbits

**Changing Game Client Resolution:**

Edit this line near the top of `setup.sh`:

```bash
readonly RES="1" # 0 = 800x600, 1 = 1024x768, 2 = 1366x768 (potentially unstable)
```
- Then run `./setup.sh` again to generate a fresh prefix with the right Virtual Desktop, Legends.ini, and WINE_DPI_SCALE configuration.

**Rezizing the Fixed Window:**

If your game window is tiny and unresizable, install `xrandr` and run `setup.sh`. Run `play.sh`, click on the maximize button on the game's window decoration, and it should now resize to fill your display and maintain aspect ratio. 
- If this doesn't work, try `gamescope`.

# Notes to Developers

Observations made while developing this script that may be of use:

1. Windows 98 has an effect on stability, at least on KDE + X11.
  - When using Windows 7, crashes at startup or while moving the window were very common, while on Windows 98 zero crashes were observed (after adding the win32* DLL overrides)
2. Winetricks isn't required to create a Wineprefix capable of launching the game, at least on Wine 10 Staging.
  - This script only uses Winetricks to install corefonts, and Windows 98 can be set with `winecfg -v`; so it's not strictly needed, but broken fonts can be subtley annoying, so even though it's like half the install time, it's probably worth it.

# Special Thanks

**Special Thanks**: deer, for https://codeberg.org/deer/maple_in_2999
