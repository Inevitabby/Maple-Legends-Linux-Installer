<div align="center">
	<h1>Maple Legends Linux Installer</h1>
</div>

# Requirements

**Software**:
- Wine with 32-bit support
- Winetricks
- bsdtar

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
- Then run `./setup.sh` again to generate a **fresh** prefix with right Virtual Desktop and Legends.ini configuration.

**Rezizing the Fixed Window:**

If your game window is fixed and unresizable, AMD users can try `gamescope`. Other people, see what your WM and DE can do (e.g., KDE has a Zoom desktop effect (just disable mouse tracking)).

Also, you may tweak the Wine DPI scale and see if that helps. Edit `play.sh` and look for:

```bash
export WINE_DPI_SCALE=96 # scale_factor = WINE_DPI_SCALE / 96
```
- *Examples: `96` = 100%; `120` = 125%; `144` = 150%; `192` = 200%*

# Special Thanks

**Special Thanks**: deer, for https://codeberg.org/deer/maple_in_2999
