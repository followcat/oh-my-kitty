#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/config"
BIN_DIR="$SCRIPT_DIR/bin"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Installing Oh My FollowCat Kitty...${NC}"

# Create directories
echo "Creating directories..."
mkdir -p ~/.config/kitty
mkdir -p ~/.local/bin
mkdir -p ~/.local/state/kitty-quick-access

# Copy config files
echo "Copying config files..."
cp "$CONFIG_DIR/kitty.conf" ~/.config/kitty/
cp "$CONFIG_DIR/dropdown.conf" ~/.config/kitty/

# Copy binary files with proper permissions
echo "Copying scripts..."
cp "$BIN_DIR/kitty-quick-access-toggle" ~/.local/bin/
chmod +x ~/.local/bin/kitty-quick-access-toggle

cp "$BIN_DIR/kitty-quick-access-resize-height" ~/.local/bin/
chmod +x ~/.local/bin/kitty-quick-access-resize-height
cp "$BIN_DIR/kitty-quick-access-new-tab" ~/.local/bin/
chmod +x ~/.local/bin/kitty-quick-access-new-tab

# Disable GNOME animations for smooth dropdown
if command -v gsettings &> /dev/null; then
    echo "Disabling GNOME animations..."
    gsettings set org.gnome.desktop.interface enable-animations false
fi

echo -e "${GREEN}✅ Installation complete!${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Restart Kitty: Ctrl+\`"
echo "2. Try the quick-access terminal: Ctrl+\`"
echo "3. Adjust height: Ctrl+↑/↓"
echo ""
echo -e "${YELLOW}Configuration files:${NC}"
echo "- ~/.config/kitty/kitty.conf"
echo "- ~/.config/kitty/dropdown.conf"
echo ""
echo -e "${YELLOW}Scripts:${NC}"
echo "- ~/.local/bin/kitty-quick-access-toggle"
echo "- ~/.local/bin/kitty-quick-access-resize-height"
echo "- ~/.local/bin/kitty-quick-access-new-tab"
