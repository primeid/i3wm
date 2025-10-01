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
| `Mod+V` | Clipboard manager (CopyQ) |
| `Mod+C` | VS Code |
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
| `XF86AudioRaiseVolume` | Volume up |
| `XF86AudioLowerVolume` | Volume down |
| `XF86AudioMute` | Toggle mute |

## Brightness

| Keybinding | Action |
|------------|--------|
| `XF86MonBrightnessUp` | Increase brightness |
| `XF86MonBrightnessDown` | Decrease brightness |

## Screenshots

| Keybinding | Action |
|------------|--------|
| `Mod+Shift+P` | Screenshot with Shutter |

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
- CopyQ clipboard manager
- pavucontrol audio control
- lxappearance theme manager

### Quick Reference Card

Print this page or keep it handy while learning i3!

---

**Pro Tip**: Most keybindings follow a logical pattern. `Mod+Key` performs an action, while `Mod+Shift+Key` performs a related but more "destructive" or permanent action.
