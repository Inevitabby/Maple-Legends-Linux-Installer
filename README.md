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

# Tips

## Changing Game Client Resolution

Edit this line near the top of `setup.sh`:

```bash
readonly RES="1" # 0 = 800x600, 1 = 1024x768, 2 = 1366x768 (potentially unstable)
```
- Then run `./setup.sh` again to generate a fresh prefix with the right Virtual Desktop, Legends.ini, and WINE_DPI_SCALE configuration.

> ![IMPORTANT]
> `RES="2"` is very likely to make your game simply not start.

## Fullscreening

Fullscreening the game is a bit finicky.

1. Start the game with `play.sh`
2. Maximize the virtual desktop window
3. Maximize the game by clicking maximize button on the game's **window decoration** (top-right) 
4. The game should resize to fill your maximized virtual desktop
	- If this didn't work, try `gamescope`.

> ![NOTE]
> Alt+Enter is buggy and doesn't work for fullscreening the game, you *have* to click on the window decoration, which may be uncomposited (so you may have to click blindly).

## Increasing DPI

If your game looks low-resolution when maximized, install `xrandr` and rerun `setup.sh`.

The setup script will calculate your DPI automatically and it should look a lot better.

> Alternatively, you can manually set DPI with the environment variable `WINE_PREFIX_DPI`

# Developer Notes

1. When using Windows 7, game crashed frequently at startup or while moving the window. It's much stabler on Windows 98.

# Special Thanks

**Special Thanks**: deer, for https://codeberg.org/deer/maple_in_2999
