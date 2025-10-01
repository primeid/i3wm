#!/bin/bash
# i3wm Performance Optimization Script
# This script replaces heavy components with lightweight Rust/C alternatives
# Expected RAM savings: 80-120MB

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}i3wm Performance Optimization Script${NC}"
echo -e "${BLUE}======================================${NC}\n"

# Function to print status
print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Check if running in i3
if ! pgrep -x "i3" > /dev/null; then
    print_warning "Not running in i3 session. Changes will take effect after restart."
fi

# Backup current config
echo -e "\n${BLUE}Step 1: Backing up current configuration${NC}"
BACKUP_DIR="$HOME/.config/i3-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"
if [ -f "$HOME/.config/i3/config" ]; then
    cp "$HOME/.config/i3/config" "$BACKUP_DIR/"
    print_status "Backed up i3 config to $BACKUP_DIR"
fi

# Ask user which optimizations to apply
echo -e "\n${BLUE}Step 2: Select optimizations to apply${NC}"
echo "This script will guide you through replacing heavy components."
echo ""

# Option 1: Replace CopyQ with clipman
echo -e "${YELLOW}Option 1: Replace CopyQ (Qt, 30-50MB) with clipman (GTK, 2-5MB)${NC}"
read -p "Apply this optimization? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Installing xfce4-clipman..."
    sudo apt update
    sudo apt install -y xfce4-clipman xfce4-clipman-plugin xclip
    
    if dpkg -l | grep -q "^ii.*copyq"; then
        print_status "Removing CopyQ..."
        sudo apt remove -y copyq copyq-plugins
        sudo apt autoremove -y
    fi
    
    print_status "CopyQ replaced with clipman"
    REPLACE_COPYQ=true
else
    print_warning "Skipping CopyQ replacement"
    REPLACE_COPYQ=false
fi

# Option 2: Replace Shutter with maim
echo -e "\n${YELLOW}Option 2: Replace Shutter (Perl, 50-80MB) with maim (C, 1-2MB)${NC}"
read -p "Apply this optimization? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Installing maim and xdotool..."
    sudo apt install -y maim xdotool xclip
    
    if dpkg -l | grep -q "^ii.*shutter"; then
        print_status "Removing Shutter..."
        sudo apt remove -y shutter
        sudo apt autoremove -y
    fi
    
    # Create Pictures directory if it doesn't exist
    mkdir -p "$HOME/Pictures"
    
    print_status "Shutter replaced with maim"
    REPLACE_SHUTTER=true
else
    print_warning "Skipping Shutter replacement"
    REPLACE_SHUTTER=false
fi

# Option 3: Optimize compositor
echo -e "\n${YELLOW}Option 3: Disable compositor (picom) to save 20-40MB RAM${NC}"
echo "Note: This will disable window transparency in alacritty and other effects"
read -p "Disable compositor? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    DISABLE_PICOM=true
    print_status "Will disable picom in configuration"
else
    print_warning "Keeping compositor enabled"
    DISABLE_PICOM=false
fi

# Option 4: Remove blueman if not using Bluetooth
echo -e "\n${YELLOW}Option 4: Remove Bluetooth applet if you don't use Bluetooth (saves 10-20MB)${NC}"
read -p "Do you use Bluetooth regularly? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]]; then
    DISABLE_BLUEMAN=true
    print_status "Will disable blueman-applet in configuration"
else
    print_warning "Keeping Bluetooth applet enabled"
    DISABLE_BLUEMAN=false
fi

# Option 5: Install optional Rust alternatives
echo -e "\n${YELLOW}Option 5: Install clipcat (Rust clipboard manager, requires cargo)${NC}"
read -p "Install clipcat? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if command -v cargo &> /dev/null; then
        print_status "Installing clipcat via cargo..."
        cargo install clipcat
        print_status "clipcat installed (to use it instead of clipman, edit config manually)"
    else
        print_error "Cargo not found. Install Rust toolchain first: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    fi
fi

# Apply configuration changes
echo -e "\n${BLUE}Step 3: Applying configuration changes${NC}"

CONFIG_FILE="$HOME/Projects/i3wm/i3/config"
OPTIMIZED_CONFIG="$HOME/Projects/i3wm/i3/config.optimized"

if [ -f "$OPTIMIZED_CONFIG" ]; then
    print_status "Using optimized configuration template"
    
    # Copy optimized config as base
    cp "$OPTIMIZED_CONFIG" "${CONFIG_FILE}.new"
    
    # Apply user choices
    if [ "$DISABLE_PICOM" = true ]; then
        sed -i 's/^exec_always --no-startup-id picom/# exec_always --no-startup-id picom/' "${CONFIG_FILE}.new"
        print_status "Disabled picom in config"
    fi
    
    if [ "$DISABLE_BLUEMAN" = true ]; then
        sed -i 's/^exec_always blueman-applet/# exec_always blueman-applet/' "${CONFIG_FILE}.new"
        print_status "Disabled blueman-applet in config"
    fi
    
    # Reduce gaps for better performance
    sed -i 's/^gaps inner 10/gaps inner 5/' "${CONFIG_FILE}.new"
    sed -i 's/^gaps outer 10/gaps outer 5/' "${CONFIG_FILE}.new"
    print_status "Reduced gaps from 10 to 5 pixels"
    
    # Move new config into place
    mv "${CONFIG_FILE}.new" "$CONFIG_FILE"
    print_status "Updated i3 configuration"
    
    # Validate config
    if i3 -C -c "$CONFIG_FILE" > /dev/null 2>&1; then
        print_status "Configuration validated successfully"
    else
        print_error "Configuration validation failed. Restoring backup..."
        cp "$BACKUP_DIR/config" "$CONFIG_FILE"
        exit 1
    fi
else
    print_warning "Optimized config template not found. Manual edit required."
fi

# Update alacritty config if transparency disabled
if [ "$DISABLE_PICOM" = true ]; then
    ALACRITTY_CONFIG="$HOME/Projects/i3wm/alacritty/alacritty.yml"
    if [ -f "$ALACRITTY_CONFIG" ]; then
        sed -i 's/^window\.opacity: 0\.5/window.opacity: 1.0/' "$ALACRITTY_CONFIG"
        print_status "Disabled alacritty transparency (compositor disabled)"
    fi
fi

# Summary
echo -e "\n${BLUE}======================================${NC}"
echo -e "${BLUE}Optimization Summary${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""
if [ "$REPLACE_COPYQ" = true ]; then
    echo -e "${GREEN}✓${NC} CopyQ → clipman (saves ~45MB)"
fi
if [ "$REPLACE_SHUTTER" = true ]; then
    echo -e "${GREEN}✓${NC} Shutter → maim (saves ~70MB)"
fi
if [ "$DISABLE_PICOM" = true ]; then
    echo -e "${GREEN}✓${NC} Compositor disabled (saves ~30MB)"
fi
if [ "$DISABLE_BLUEMAN" = true ]; then
    echo -e "${GREEN}✓${NC} Bluetooth applet disabled (saves ~15MB)"
fi

echo ""
echo -e "${YELLOW}Estimated total RAM savings: 80-160MB${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Reload i3 configuration: Super+Shift+C"
echo "2. Or restart i3: Super+Shift+R"
echo "3. Monitor memory usage: htop or ps aux"
echo ""
echo -e "${BLUE}New keybindings:${NC}"
if [ "$REPLACE_SHUTTER" = true ]; then
    echo "  Super+Shift+P  - Screenshot selection (maim)"
    echo "  Print          - Full screenshot"
    echo "  Super+Print    - Active window screenshot"
fi
if [ "$REPLACE_COPYQ" = true ]; then
    echo "  Super+V        - Clipboard history (clipman)"
fi
echo ""
echo -e "${GREEN}Optimization complete!${NC}"
echo -e "${YELLOW}Backup saved to: $BACKUP_DIR${NC}"
