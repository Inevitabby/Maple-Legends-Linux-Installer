<div align="center">
	<h1>Maple Legends Linux Installer</h1>
	<p>Last Tested Version: <pre>MapleLegends-MAC11JAN2026</pre></p>
</div>

# Requirements

**Software**:
- bsdtar
- xrandr (optional, for calculating DPI)

**User Responsibilities**:
- Place the latest Mac Wineskin `.pkg` for Maple Legends in the root directory of this project _(see [Instructions](#instructions))_.

# Instructions

**1. Clone repository**

```bash
git clone https://github.com/inevitabby/maple-legends-linux-installer
cd maple-legends-linux-installer
```

**2. Download game files**

Download the Mac **Wineskin** `.pkg` for Maple Legends (**not Crossover**) from [Maple Legends forums](https://forum.maplelegends.com/index.php?forums/announcements/)
- Place the `.pkg` in the root directory of this project.

**3. Run setup script** *(this will take a while)*

```bash
./setup.sh
```

**4. Launch the game**

```bash
./play.sh
```

# Helpful Tidbits

**Changing Game Client Resolution:**

Edit this line near the top of `setup.sh`:

```bash
readonly RES="1" # 0 = 800x600, 1 = 1024x768, 2 = 1366x768 (potentially unstable)
```
- Then run `./setup.sh` again to generate a fresh prefix with the right Virtual Desktop, Legends.ini, and WINE_DPI_SCALE configuration.

**Rezizing the Fixed Window:**

If your game window is tiny and unresizable, install `xrandr` and rerun `setup.sh`.

Start the game with `play.sh` and **click on the maximize button** on the game's window decoration (Alt+Enter is buggy!). The game should resize to fill your display and maintain aspect ratio. 
- If this doesn't work, try `gamescope`.

# Notes to Developers

Observations made while developing this script that may be of use:

1. When using Windows 7, crashes at startup or while moving the window were very common; while on Windows 98 zero crashes were observed (after adding the win32* DLL overrides)

# Special Thanks

**Special Thanks**: deer, for https://codeberg.org/deer/maple_in_2999
