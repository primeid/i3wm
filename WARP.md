# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Overview

This repository contains a complete i3 window manager configuration for Pop!_OS 24.04, adapted from the [primeid/NixOS-Config](https://github.com/primeid/NixOS-Config) repository. It provides a tiling window manager setup with the Srcery color scheme, featuring symlinked configuration files for easy version control and management.

## Repository Structure

```
~/Projects/i3wm/
├── i3/config              # Main i3 window manager configuration
├── i3status/config        # Status bar configuration (network, battery, CPU, memory, etc.)
├── alacritty/alacritty.yml # Terminal emulator configuration with Srcery theme
├── install.sh             # Automated installation script
├── README.md              # Comprehensive setup and usage documentation
├── KEYBINDINGS.md         # Complete keybinding reference
└── INSTALLATION_LOG.md    # Detailed installation summary
```

### Configuration Files Are Symlinked

All configuration files in this repo are designed to be symlinked to their active locations:
- `~/Projects/i3wm/i3/config` → `~/.config/i3/config`
- `~/Projects/i3wm/i3status/config` → `~/.config/i3status/config`
- `~/Projects/i3wm/alacritty/alacritty.yml` → `~/.config/alacritty/alacritty.yml`

This allows version control of configs while keeping them active.

## Common Commands

### Installation and Setup

```bash
# Fresh installation (creates symlinks, backs up existing configs)
./install.sh

# Manually create symlinks
ln -sf ~/Projects/i3wm/i3/config ~/.config/i3/config
ln -sf ~/Projects/i3wm/i3status/config ~/.config/i3status/config
ln -sf ~/Projects/i3wm/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# Validate i3 config syntax before applying
i3 -C -c ~/Projects/i3wm/i3/config
```

### Testing and Reloading Changes

```bash
# Check i3 config syntax (returns non-zero if errors)
i3 -C -c ~/Projects/i3wm/i3/config

# Reload i3 configuration (applies changes without restarting windows)
i3-msg reload

# Restart i3 in place (reloads everything, maintains session)
i3-msg restart

# Test from within i3: Mod+Shift+C (reload) or Mod+Shift+R (restart)
```

### Viewing Active Configuration

```bash
# Show current i3 config (avoid cat, use sed for programmatic access)
sed -n '1,100p' ~/.config/i3/config

# Show current i3status config
sed -n '1,100p' ~/.config/i3status/config

# View i3 log messages
i3-msg -t get_log

# Check i3bar status
i3-msg -t get_bar_config
```

### System Integration

```bash
# View X11 logs (for display issues)
sed -n '1,100p' ~/.local/share/xorg/Xorg.0.log

# Check system logs related to display/session
journalctl -xe --no-pager | grep -i "i3\|x11\|display" | tail -50

# List available desktop sessions
ls -la /usr/share/xsessions/
```

## Key Architecture Concepts

### Modifier Keys
- `$mod` = Mod4 (Super/Windows key) - Primary modifier for all i3 commands
- `$alt` = Mod1 (Alt key) - Secondary modifier (defined but minimal usage)
- All keybindings use Super key to avoid conflicts with applications

### Color Scheme: Srcery
The entire setup uses Srcery, a dark high-contrast theme:
- Background: `#1C1B19` (dark brown-black)
- Foreground: `#BAA67F` (tan/beige)
- Accent: `#EF2F27` (red for focused window borders)
- All three configs (i3, i3status, alacritty) use matching colors

### Workspace-to-Monitor Assignment
Multi-monitor support is built-in with hardcoded assignments:
- Workspaces 1-7: Assigned to `DP-1` (external monitor, primary)
- Workspaces 8-10: Assigned to `eDP-1` (laptop screen)
- These are defined around lines 113-122 of `i3/config`
- Users with single monitors can ignore these; they're harmless

### Gaps Configuration
- Inner gaps: 10px (space between windows)
- Outer gaps: 10px (space around screen edges)
- Dynamically adjustable via `Mod+Plus` and `Mod+Minus`
- Controlled by `gaps inner` and `gaps outer` directives

### Autostart Programs
The following auto-start on i3 session initialization (via `exec_always` or `exec`):
- copyq (clipboard manager)
- shutter (screenshot tool, minimized)
- nm-applet (network manager tray)
- blueman-applet (Bluetooth tray)
- picom (compositor for transparency/effects)
- xbanish (hides cursor when typing)
- xsetroot (sets background color)
- Keyboard settings (xset, setxkbmap)

### Commented-Out NixOS-Specific Tools
These tools from the original NixOS config are NOT installed:
- `i3altlayout` - Automatic layout manager (NixOS-specific)
- `i3wsr` - Workspace renamer (NixOS-specific)
- Multi-monitor xrandr line is commented out (line 19 of i3/config)

Users can safely ignore commented-out sections unless they want to enable them.

## Making Configuration Changes

### Modifying Keybindings
1. Edit `i3/config` in this repo
2. Find the `bindsym` lines (e.g., line 49-66)
3. Add/modify bindings following format: `bindsym $mod+<key> exec <command>`
4. Validate: `i3 -C -c ~/Projects/i3wm/i3/config`
5. Reload: `i3-msg reload`

### Adjusting Status Bar Items
1. Edit `i3status/config` in this repo
2. Modify the `order +=` lines (lines 9-16) to add/remove items
3. Configure individual modules (lines 18-61)
4. Reload: `i3-msg reload` (i3status auto-reloads when config changes)

### Changing Colors
Since all three configs use Srcery:
1. To change i3 borders: Edit `client.focused` line (line 106 of i3/config)
2. To change i3bar colors: Edit `colors {}` block in bar section (lines 180-188)
3. To change i3status colors: Edit `color_good`, `color_degraded`, `color_bad` (lines 4-6 of i3status/config)
4. To change terminal colors: Edit `colors:` section of alacritty.yml (lines 30-56)

### Terminal Opacity
Terminal transparency is set via `window.opacity: 0.5` in alacritty.yml (line 23). Adjust between 0.0-1.0.

## Development Workflow

### Typical Change Flow
1. Edit config files in `~/Projects/i3wm/`
2. Validate syntax: `i3 -C -c ~/Projects/i3wm/i3/config`
3. Test changes: `i3-msg reload` (or Mod+Shift+C)
4. If satisfied, commit changes
5. Push to GitHub for backup/sharing

### When Things Break
```bash
# Switch to TTY (Ctrl+Alt+F3) if i3 becomes unusable
# Fix the config file
# Return to X session (Ctrl+Alt+F1 or F2)

# Or log out and select COSMIC desktop environment at login
# Fix configs from COSMIC environment
# Log back into i3
```

### Testing Display Configuration
```bash
# Launch arandr for GUI-based multi-monitor setup
arandr

# Apply saved layout
xrandr --output DP-1 --mode 3840x2160 --primary --output eDP-1 --mode 1920x1080 --right-of DP-1

# Add xrandr command to i3/config as exec_always (line 19)
```

## Important Context for AI Assistants

### This is NOT a Software Development Project
This repository contains **dotfiles/configuration files**, not application code. There are:
- No build systems
- No test suites
- No linting beyond `i3 -C` syntax validation
- No package.json, Makefile, or similar

### The install.sh Script
- Creates necessary directories
- Backs up existing configs with timestamps
- Creates symlinks to repo files
- One-time setup, not a development build step

### Session Switching
This configuration coexists with Pop!_OS's COSMIC desktop:
- At login, select "i3" from session menu to use this config
- Select "COSMIC" to use default Pop!_OS desktop
- Both desktop environments coexist peacefully on Pop!_OS 24.04

### Configuration Validation is Simple
- Only `i3 -C -c <config>` is needed to validate i3/config
- i3status and alacritty configs have no standalone validation tools
- Errors typically surface when reloading i3 or launching alacritty

### No CI/CD or Automated Testing
Changes are tested manually by:
1. Reloading i3 configuration
2. Observing behavior
3. Checking i3 logs if issues occur

### Color Scheme Consistency
When making color changes, maintain Srcery theme consistency across:
- i3/config (window borders, bar colors)
- i3status/config (status item colors)
- alacritty/alacritty.yml (terminal colors)

All three files reference the same hex color values.
