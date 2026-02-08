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

# Tips / Problem Solving

> [!IMPORTANT]
> **tl;dr**: If you have a graphical quirk, install `xrandr` and re-run `setup.sh`!
> 
> If that doesn't doesn't fix your issue, then consult these tips.

## Changing Game Client Resolution

1. Edit this line near the top of `setup.sh`:

```bash
readonly RES="1" # 0 = 800x600, 1 = 1024x768, 2 = 1366x768 (potentially unstable)
```

2. Then run `./setup.sh` again to generate a prefix with the right settings.

> [!CAUTION]
> `RES="2"` is very likely to make your game simply crash on start.
> 
> You should try it and see if it works, but it probably won't.

## Increasing DPI

**1. Automatic**

If your game looks low-resolution, install `xrandr` and rerun `setup.sh`.

The setup script will calculate your DPI automatically, making the game look better.

**2. Manual**

If `xrandr` isn't available, you can manually set DPI by editting the registry or using Winetricks.

Remember that the `WINEPREFIX` is `$(basename .wine)` (has to be absolute path)

## Fullscreening

Fullscreening the game is a bit finicky.

1. Start the game with `play.sh`
2. Make the virtual desktop window **full screen**[^fn1]
3. Maximize the game by clicking maximize button on the game's **window decoration** (top-right) 
4. The game should resize to fill your maximized virtual desktop
	- If this didn't work, try `gamescope`.

[^fn1]: When I say **full screen**, I don't mean "maximized but with 5% of the top pulled down so I can see my hipster polybar", I mean **full screen**—like it goes across your full display!

> [!NOTE]
> Alt+Enter is buggy and doesn't work for fullscreening the game, you *have* to click on the window decoration, which may be uncomposited (so you may have to click with an invisible mouse).

## Fixing Window Overflow

If you don't want to fullscreen the virtual desktop but still want to maximize the game, you may find that the game overflows past the bottom of the virtual desktop.

To fix this, you'll need to add a **manual offset** that shaves off the pixels from the virtual desktop that you aren't using.

Edit this line near the top of `setup.sh`:

```bash
readonly OFFSET=0
```

This offset is the number of pixels subtracted from the virtual desktop's resolution (from each dimension).

The virtual desktop's default resolution is best-fit for your display resolution and aspect ratio-preserving for your game (very important, because otherwise you'd get a stretched game).

As you aren't using your entire display resolution, you'll have to increase the `OFFSET` until the game fits inside whatever smaller box it is that you are trying to put it in.

> [!NOTE]
> On tiling window managers, the size of the virtual desktop can be extremely non-obvious because of how your WM force-resizes windows beyond their limits.
> 
> This plays badly with a fixed-resolution game and can manifest in the form of uncomposited portions of the window. I recommend docking your game and having a consistent setup for it.

# Developer Notes

1. When using Windows 7, game crashed frequently at startup or while moving the window. It's much stabler on Windows 98.
2. The actual game files are identical between Crossover .cxarchive and Wineskin .pkg. 
	- Crossover just has more junk inside of it and some symbolic links that make simultaneous selective extraction and flattening a PITA; hence why I only support the smaller and way easier .pkg files.
3. If you set Virtual Desktop resolution to your display resolution, if your display isn't the same aspect ratio as the game you will get wonky scaling not only in the game, but the inputs (the stretched axis will move faster); if you don't like how a virtual desktop looks, you *really* won't like an unplayable stretched game.

# Special Thanks

**Special Thanks**: deer, for https://codeberg.org/deer/maple_in_2999
