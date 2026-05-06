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

# Backup existing files before replacing files managed by this project.
backup_if_changed() {
    src="$1"
    dest="$2"

    if [ -f "$dest" ] && ! cmp -s "$src" "$dest"; then
        backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
        cp "$dest" "$backup"
        echo "Backed up existing file: $backup"
    fi
}

install_file() {
    src="$1"
    dest="$2"
    mode="${3:-0644}"

    backup_if_changed "$src" "$dest"
    cp "$src" "$dest"
    chmod "$mode" "$dest"
}

render_config() {
    src="$1"
    dest="$2"
    tmp="$(mktemp)"
    sed "s|@HOME@|$HOME|g" "$src" > "$tmp"
    install_file "$tmp" "$dest"
    rm -f "$tmp"
}

# Copy config files
echo "Copying config files..."
render_config "$CONFIG_DIR/kitty.conf" "$HOME/.config/kitty/kitty.conf"
render_config "$CONFIG_DIR/dropdown.conf" "$HOME/.config/kitty/dropdown.conf"

# Copy binary files with proper permissions
echo "Copying scripts..."
install_file "$BIN_DIR/kitty-quick-access-toggle" "$HOME/.local/bin/kitty-quick-access-toggle" 0755

install_file "$BIN_DIR/kitty-quick-access-resize-height" "$HOME/.local/bin/kitty-quick-access-resize-height" 0755
install_file "$BIN_DIR/kitty-quick-access-new-tab" "$HOME/.local/bin/kitty-quick-access-new-tab" 0755
install_file "$BIN_DIR/kitty-shortcuts-help" "$HOME/.local/bin/kitty-shortcuts-help" 0755

add_custom_keybinding_path() {
    path="$1"
    current="$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)"

    case "$current" in
        *"$path"*) return 0 ;;
        "@as []"|"[]") next="['$path']" ;;
        *) next="${current%]}, '$path']" ;;
    esac

    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$next"
}

set_custom_keybinding() {
    path="$1"
    name="$2"
    command="$3"
    binding="$4"
    schema="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$path"

    add_custom_keybinding_path "$path"
    gsettings set "$schema" name "$name"
    gsettings set "$schema" command "$command"
    gsettings set "$schema" binding "$binding"
}

install_gnome_shortcuts() {
    if ! command -v gsettings >/dev/null 2>&1; then
        echo "gsettings not found; skipping GNOME shortcuts."
        return
    fi

    echo "Installing GNOME global shortcuts..."
    set_custom_keybinding \
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty-quick-access/" \
        "Kitty Quick Access" \
        "$HOME/.local/bin/kitty-quick-access-toggle" \
        "<Primary>asciitilde"
    set_custom_keybinding \
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty-quick-access-height-up/" \
        "Kitty Quick Access Height Up" \
        "$HOME/.local/bin/kitty-quick-access-resize-height -80" \
        "<Control>Up"
    set_custom_keybinding \
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty-quick-access-height-down/" \
        "Kitty Quick Access Height Down" \
        "$HOME/.local/bin/kitty-quick-access-resize-height 80" \
        "<Control>Down"
}

install_gnome_shortcuts

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
echo "- ~/.local/bin/kitty-shortcuts-help"
