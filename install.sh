#!/bin/bash
# i3wm Installation Script for Pop!_OS
# Based on primeid/NixOS-Config

set -e

echo "================================"
echo "i3wm Installation for Pop!_OS"
echo "================================"
echo ""

# Check if running on Pop!_OS
if [ ! -f /etc/os-release ] || ! grep -q "Pop!_OS" /etc/os-release; then
    echo "⚠️  Warning: This script is designed for Pop!_OS"
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo "📦 Installing required packages..."
sudo apt update
sudo apt install -y \
    i3 i3lock i3status \
    rofi picom alacritty \
    pavucontrol playerctl \
    copyq blueman xbanish \
    shutter arandr feh xbacklight \
    nautilus \
    fonts-firacode fonts-font-awesome

echo ""
echo "📁 Creating config directories..."
mkdir -p ~/.config/{i3,i3status,alacritty}

echo ""
echo "🔗 Creating symlinks..."

# Backup existing configs if they exist
if [ -f ~/.config/i3/config ]; then
    echo "  Backing up existing i3 config..."
    mv ~/.config/i3/config ~/.config/i3/config.backup.$(date +%Y%m%d_%H%M%S)
fi

if [ -f ~/.config/i3status/config ]; then
    echo "  Backing up existing i3status config..."
    mv ~/.config/i3status/config ~/.config/i3status/config.backup.$(date +%Y%m%d_%H%M%S)
fi

if [ -f ~/.config/alacritty/alacritty.yml ]; then
    echo "  Backing up existing alacritty config..."
    mv ~/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml.backup.$(date +%Y%m%d_%H%M%S)
fi

# Create symlinks
ln -sf ~/Projects/i3wm/i3/config ~/.config/i3/config
ln -sf ~/Projects/i3wm/i3status/config ~/.config/i3status/config
ln -sf ~/Projects/i3wm/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

echo ""
echo "✅ Installation complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Log out of your current session"
echo "  2. At the login screen, select 'i3' from the session menu"
echo "  3. Log in and press Super+Space to launch rofi"
echo ""
echo "📚 Documentation:"
echo "  - README.md for full documentation"
echo "  - KEYBINDINGS.md for keyboard shortcuts"
echo ""
echo "🎨 Color scheme: Srcery"
echo "🔑 Modifier key: Super (Windows key)"
echo ""
echo "Enjoy your new tiling window manager! 🚀"
