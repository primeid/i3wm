# i3 Window Manager Installation Summary

## Installation Complete! ✓

i3wm has been successfully installed on Pop!_OS 24.04 alongside COSMIC desktop environment.

### What was installed:

#### Core i3 Components:
- **i3-wm** - The tiling window manager
- **i3status** - Status bar with custom configuration
- **i3lock** - Screen locker
- **rofi** - Application launcher (Super+Space)

#### Supporting Applications:
- **alacritty** - GPU-accelerated terminal (Super+Enter)
- **picom** - Compositor for transparency and effects
- **nautilus** - File manager (Super+E)
- **copyq** - Clipboard manager (Super+V)
- **shutter** - Screenshot tool (Super+Shift+P)
- **arandr** - Display configuration GUI
- **feh** - Image viewer and wallpaper setter
- **xbanish** - Auto-hide cursor when typing
- **pavucontrol** - Audio control
- **playerctl** - Media player control
- **blueman** - Bluetooth manager
- **xbacklight** - Brightness control

#### Fonts:
- Fira Code (terminal font)
- Font Awesome 5 Free (status bar icons)
- DejaVu Sans Mono

### Configuration Files:

All configs based on the NixOS-Config repository with Pop!_OS adaptations:

- **i3 config**: `~/.config/i3/config`
  - Srcery color scheme (#1C1B19, #BAA67F, #EF2F27)
  - 10px gaps (inner/outer)
  - Smart borders
  - Custom keybindings (see below)

- **i3status config**: `~/.config/i3status/config`
  - Srcery color scheme
  - Shows: WiFi, Ethernet, Battery, Disk, CPU, Memory, Volume, Time

- **Alacritty config**: `~/.config/alacritty/alacritty.yml`
  - Fira Code 12pt
  - 50% opacity
  - Srcery colors

### Key Bindings (Mod = Super/Windows key):

#### Window Management:
- `Mod+Enter` - Open terminal (alacritty)
- `Mod+Q` - Kill focused window
- `Mod+F` - Toggle fullscreen
- `Mod+Shift+Space` - Toggle floating
- `Mod+Arrow Keys` - Focus windows
- `Mod+Shift+Arrow Keys` - Move windows
- `Mod+R` - Resize mode (use arrows, Esc to exit)

#### Applications:
- `Mod+Space` - Rofi launcher
- `Mod+E` - File manager (nautilus)
- `Mod+W` - Firefox (new window)
- `Mod+Shift+W` - Firefox (private window)
- `Mod+V` - Clipboard manager (copyq)
- `Mod+C` - VS Code

#### Workspaces:
- `Mod+1-0` - Switch to workspace 1-10
- `Mod+Shift+1-0` - Move window to workspace
- `Mod+Tab` - Back and forth between workspaces
- `Mod+Page Up/Down` - Previous/Next workspace

#### System:
- `Mod+L` - Lock screen
- `Mod+Shift+L` - Log out
- `Mod+Shift+End` - Power off
- `Mod+Shift+B` - Reboot
- `Mod+Shift+C` - Reload i3 config
- `Mod+Shift+R` - Restart i3

#### Gaps:
- `Mod+Plus` - Increase gaps
- `Mod+Minus` - Decrease gaps

#### Media Keys:
- `XF86AudioPlay` - Play/pause
- `XF86AudioNext/Prev` - Next/previous track
- `XF86AudioRaiseVolume/LowerVolume` - Volume up/down
- `XF86AudioMute` - Mute toggle
- `XF86MonBrightnessUp/Down` - Brightness control

#### Screenshots:
- `Mod+Shift+P` - Screenshot with shutter

### Autostart Programs:

The following start automatically with i3:
- copyq (clipboard manager)
- shutter (screenshot tool - minimized)
- nm-applet (network manager)
- blueman-applet (Bluetooth)
- picom (compositor)
- xbanish (cursor hider)
- Custom keyboard settings (200ms delay, 42 repeat rate, caps->ctrl)
- Background color (#3a3a3a)

### How to Use:

1. **Log out** of your current session
2. At the login screen (COSMIC Greeter), look for a **session selector** (usually a gear/cog icon)
3. Select **"i3"** from the list
4. Log in with your password
5. Press `Mod+Space` (Super+Space) to open rofi and start launching apps!

### Notes:

- **Display Manager**: Pop!_OS uses COSMIC Greeter (greetd), not LightDM
- **NixOS-specific tools not installed**: i3altlayout, i3wsr (commented out in config)
- **Multi-monitor setup**: The xrandr line is commented out - configure with arandr if needed
- **i3status-rust**: Not installed due to compilation time - using regular i3status instead
- **Browser**: Changed from Thorium/Chromium to Firefox (not installed in NixOS config)

### Customization:

To customize further:
- Edit `~/.config/i3/config` for window manager settings
- Edit `~/.config/i3status/config` for status bar
- Edit `~/.config/alacritty/alacritty.yml` for terminal
- Run `arandr` for display configuration
- Use `lxappearance` for GTK theme (install with: `sudo apt install lxappearance`)

### Troubleshooting:

If something doesn't work:
1. Check config syntax: `i3 -C -c ~/.config/i3/config`
2. Reload config: `Mod+Shift+C`
3. Restart i3: `Mod+Shift+R`
4. Check logs: `~/.local/share/xorg/Xorg.0.log` or `journalctl -xe`

### Switching Back to COSMIC:

Simply log out and select "COSMIC" from the session selector at login.

---

**Color Scheme**: Srcery
- Background: #1C1B19
- Foreground: #BAA67F  
- Red: #EF2F27
- Green: #519F50
- Yellow: #FBB829
- Blue: #2C78BF

Enjoy your new tiling window manager setup! 🚀
