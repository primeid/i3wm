# i3wm Configuration for Pop!_OS

A complete i3 window manager setup for Pop!_OS 24.04, based on the [primeid/NixOS-Config](https://github.com/primeid/NixOS-Config) repository with adaptations for Debian-based systems.

## Features

- 🎨 **Srcery color scheme** - Dark, high-contrast theme
- 🖥️ **i3-gaps** - Beautiful spacing between windows
- ⚡ **Optimized keybindings** - Intuitive and productive shortcuts
- 🔧 **Complete tooling** - Compositor, launcher, terminal, and utilities
- 🔗 **Symlinked configs** - Easy management and version control
- 🎯 **Zero configuration** - Works out of the box

## Installation

### Quick Install

```bash
# Clone this repository
git clone https://github.com/primeid/i3wm-popos.git ~/Projects/i3wm
cd ~/Projects/i3wm

# Run the install script
./install.sh
```

### Manual Installation

#### 1. Install Required Packages

```bash
sudo apt update
sudo apt install -y i3 i3lock i3status rofi picom alacritty pavucontrol \
  playerctl xfce4-clipman blueman xbanish arandr feh xbacklight \
  nautilus fonts-firacode fonts-font-awesome maim xdotool xclip dunst
```

#### 2. Create Config Directories

```bash
mkdir -p ~/.config/{i3,i3status,alacritty}
```

#### 3. Create Symlinks

```bash
ln -sf ~/Projects/i3wm/i3/config ~/.config/i3/config
ln -sf ~/Projects/i3wm/i3status/config ~/.config/i3status/config
ln -sf ~/Projects/i3wm/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
```

#### 4. Log Out and Select i3

At the login screen (COSMIC Greeter), select **i3** from the session menu.

## Configuration Files

```
~/Projects/i3wm/
├── i3/
│   └── config              # Main i3 configuration
├── i3status/
│   └── config              # Status bar configuration
├── alacritty/
│   └── alacritty.yml       # Terminal emulator configuration
├── install.sh              # Installation script
├── README.md               # This file
└── KEYBINDINGS.md          # Complete keybinding reference
```

## Key Bindings

**Modifier Key**: `Super` (Windows key)

### Essential Shortcuts

| Shortcut | Action |
|----------|--------|
| `Mod+Enter` | Open terminal (Alacritty) |
| `Mod+Space` | Application launcher (Rofi) |
| `Mod+Q` | Close window |
| `Mod+E` | File manager |
| `Mod+W` | Web browser |
| `Mod+L` | Lock screen |

See [KEYBINDINGS.md](KEYBINDINGS.md) for the complete list.

## Included Applications

### Core Components
- **i3-wm** - Tiling window manager
- **i3status** - Status bar
- **i3lock** - Screen locker
- **rofi** - Application launcher

### Utilities
- **alacritty** - GPU-accelerated terminal
- **picom** - Compositor (transparency & effects)
- **xfce4-clipman** - Lightweight clipboard manager
- **maim** - Screenshot tool (with xclip for clipboard)
- **dunst** - Notification daemon
- **arandr** - Display configuration
- **feh** - Image viewer & wallpaper setter
- **pavucontrol** - Audio control
- **blueman** - Bluetooth manager
- **xbanish** - Hide cursor when typing

## Color Scheme

**Srcery** - A dark color scheme with high contrast

```
Background:  #1C1B19
Foreground:  #BAA67F
Red:         #EF2F27
Green:       #519F50
Yellow:      #FBB829
Blue:        #2C78BF
Magenta:     #E02C6D
Cyan:        #0AAEB3
```

## Customization

### Changing Gaps

Edit `~/Projects/i3wm/i3/config`:

```bash
# Gap Settings
gaps inner 10
gaps outer 10
```

Or use keybindings:
- `Mod+Plus` - Increase gaps
- `Mod+Minus` - Decrease gaps

### Modifying Status Bar

Edit `~/Projects/i3wm/i3status/config` to:
- Add/remove status blocks
- Change colors
- Adjust update intervals

### Terminal Theme

Edit `~/Projects/i3wm/alacritty/alacritty.yml` to:
- Change colors
- Adjust font size
- Modify opacity

After making changes, reload i3: `Mod+Shift+C`

## Autostart Programs

These applications start automatically with i3:

- startup.sh (stops COSMIC services to save RAM/battery)
- xfce4-clipman (clipboard manager)
- nm-applet (network manager)
- blueman-applet (Bluetooth)
- picom (compositor with optimized settings)
- xbanish (cursor hider)
- dunst (notification daemon)
- Custom keyboard settings (caps lock as ctrl, faster key repeat)

Edit the `exec` and `exec_always` lines in `i3/config` to modify.

## Multi-Monitor Setup

The default config has multi-monitor xrandr commands commented out.

To configure displays:
1. Run `arandr` for GUI configuration
2. Save the layout
3. Add the xrandr command to `i3/config`

Or manually edit the commented xrandr line in the config.

## Troubleshooting

### Config Syntax Error

```bash
# Check config syntax
i3 -C -c ~/Projects/i3wm/i3/config
```

### Reload Configuration

Press `Mod+Shift+C` or run:
```bash
i3-msg reload
```

### Restart i3

Press `Mod+Shift+R` or run:
```bash
i3-msg restart
```

### View Logs

```bash
# X11 logs
~/.local/share/xorg/Xorg.0.log

# System logs
journalctl -xe
```

## Switching Between Desktop Environments

At the login screen, use the session selector to switch between:
- **i3** - This tiling window manager
- **COSMIC** - Pop!_OS default desktop

## Differences from NixOS Config

- ✅ Uses regular i3status (not i3status-rust)
- ✅ Browser changed to Firefox (instead of Thorium/Chromium)
- ✅ Adapted for Debian/Ubuntu package names
- ❌ i3altlayout not installed (NixOS-specific)
- ❌ i3wsr not installed (NixOS-specific)

## Credits

- Original configuration: [primeid/NixOS-Config](https://github.com/primeid/NixOS-Config)
- Color scheme: [Srcery](https://github.com/srcery-colors/srcery-vim)
- i3 window manager: [i3wm.org](https://i3wm.org/)

## License

This configuration is provided as-is. See individual component licenses for details.

## Contributing

Found an issue or have an improvement? Feel free to open an issue or pull request!

---

**Enjoy your new tiling window manager! 🚀**
