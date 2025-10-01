# i3wm Keybindings Reference

**Modifier Key**: `Mod` = `Super` / `Windows` key

## Window Management

| Keybinding | Action |
|------------|--------|
| `Mod+Enter` | Open terminal (Alacritty) |
| `Mod+Q` | Kill focused window |
| `Mod+F` | Toggle fullscreen |
| `Mod+Shift+Space` | Toggle floating mode |
| `Mod+Arrow Keys` | Focus window in direction |
| `Mod+Shift+Arrow Keys` | Move window in direction |
| `Mod+R` | Enter resize mode |

### Resize Mode
When in resize mode (`Mod+R`):
- `Arrow Keys` - Resize window
- `Enter` or `Escape` - Exit resize mode

## Applications

| Keybinding | Action |
|------------|--------|
| `Mod+Space` | Application launcher (Rofi) |
| `Mod+E` | File manager (Nautilus) |
| `Mod+W` | Firefox - New window |
| `Mod+Shift+W` | Firefox - Private window |
| `Mod+V` | Clipboard manager (xfce4-clipman) |
| `Mod+C` | VS Code (disabled - not installed) |
| `Mod+M` | htop (system monitor) in workspace 9 |

## Workspaces

| Keybinding | Action |
|------------|--------|
| `Mod+1` through `Mod+0` | Switch to workspace 1-10 |
| `Mod+Shift+1` through `Mod+Shift+0` | Move window to workspace 1-10 |
| `Mod+Tab` | Switch to previous workspace |
| `Mod+Page_Up` | Previous workspace |
| `Mod+Page_Down` | Next workspace |

## System Control

| Keybinding | Action |
|------------|--------|
| `Mod+L` | Lock screen |
| `Mod+Shift+L` | Log out (exit i3) |
| `Mod+Shift+End` | Power off |
| `Mod+Shift+B` | Reboot |
| `Mod+Shift+C` | Reload i3 configuration |
| `Mod+Shift+R` | Restart i3 in place |

## Gaps

| Keybinding | Action |
|------------|--------|
| `Mod+Plus` | Increase inner gaps |
| `Mod+Minus` | Decrease inner gaps |

## Media Controls

| Keybinding | Action |
|------------|--------|
| `XF86AudioPlay` | Play/Pause |
| `XF86AudioNext` | Next track |
| `XF86AudioPrev` | Previous track |
| `XF86AudioRaiseVolume` | Volume up (with notification) |
| `XF86AudioLowerVolume` | Volume down (with notification) |
| `XF86AudioMute` | Toggle mute (with notification) |

## Brightness

| Keybinding | Action |
|------------|--------|
| `XF86MonBrightnessUp` | Increase brightness |
| `XF86MonBrightnessDown` | Decrease brightness |

## Screenshots

| Keybinding | Action |
|------------|--------|
| `Mod+Shift+P` | Screenshot selection (maim - to clipboard & file) |
| `Print` | Full screen screenshot |
| `Mod+Print` | Active window screenshot |

## Layout Management

| Keybinding | Action |
|------------|--------|
| `Mod+Ctrl+S` | Stacking layout |
| `Mod+Ctrl+T` | Tabbed layout |
| `Mod+Ctrl+E` | Toggle split layout |
| `Mod+H` | Split horizontal |
| `Mod+Ctrl+V` | Split vertical |

## Container Focus

| Keybinding | Action |
|------------|--------|
| `Mod+A` | Focus parent container |
| `Mod+D` | Focus child container |

## Scratchpad

| Keybinding | Action |
|------------|--------|
| `Mod+Shift+BackSpace` | Move window to scratchpad |
| `Mod+BackSpace` | Show/hide scratchpad |

## Border Controls

| Keybinding | Action |
|------------|--------|
| `Mod+U` | Remove window borders |
| `Mod+N` | Normal borders with title |
| `Mod+O` | 1-pixel borders |

## Multi-Monitor

| Keybinding | Action |
|------------|--------|
| `Mod+Ctrl+Shift+Left` | Move workspace to left monitor |
| `Mod+Ctrl+Shift+Right` | Move workspace to right monitor |

## Special

| Keybinding | Action |
|------------|--------|
| `Mod+G` | Open YouTube in kiosk mode (fullscreen) |

## Tips

### Moving Between Monitors
If you have multiple monitors:
- Focus windows normally with arrow keys
- Workspaces 1-7 are assigned to primary monitor (DP-1)
- Workspaces 8-10 are assigned to laptop screen (eDP-1)

### Floating Windows
These windows float by default:
- Yad dialogs
- xfce4-clipman clipboard manager settings
- pavucontrol audio control
- lxappearance theme manager

### Layout Modes Explained
- **Stacking** (`Mod+Ctrl+S`): Windows stack vertically with tabs
- **Tabbed** (`Mod+Ctrl+T`): Windows appear as tabs (like browser tabs)
- **Split** (`Mod+Ctrl+E`): Default tiling mode, side-by-side

### Scratchpad
The scratchpad is a hidden workspace for temporary windows:
- Store any window with `Mod+Shift+BackSpace`
- Retrieve it with `Mod+BackSpace`
- Perfect for calculator, notes, or music player

### Quick Reference Card

Print this page or keep it handy while learning i3!

---

**Pro Tip**: Most keybindings follow a logical pattern. `Mod+Key` performs an action, while `Mod+Shift+Key` performs a related but more "destructive" or permanent action. `Mod+Ctrl+Key` is used for layout and advanced controls.
