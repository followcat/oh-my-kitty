#!/bin/bash
set -e

KEYBINDINGS_SCHEMA="org.gnome.settings-daemon.plugins.media-keys"
CUSTOM_SCHEMA="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"

PROJECT_KEYBINDINGS="
/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty-quick-access/
/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty-quick-access-height-up/
/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty-quick-access-height-down/
"

echo "Uninstalling Oh My FollowCat Kitty..."

rm -f "$HOME/.config/kitty/kitty.conf"
rm -f "$HOME/.config/kitty/dropdown.conf"
rm -f "$HOME/.local/bin/kitty-quick-access-toggle"
rm -f "$HOME/.local/bin/kitty-quick-access-resize-height"
rm -f "$HOME/.local/bin/kitty-quick-access-new-tab"
rm -f "$HOME/.local/bin/kitty-shortcuts-help"
rm -rf "$HOME/.local/state/kitty-quick-access"

if command -v gsettings >/dev/null 2>&1; then
    current="$(gsettings get "$KEYBINDINGS_SCHEMA" custom-keybindings)"

    for path in $PROJECT_KEYBINDINGS; do
        current="$(printf '%s\n' "$current" | sed "s|'$path', ||; s|, '$path'||; s|'$path'||")"
        schema="$CUSTOM_SCHEMA:$path"
        gsettings reset "$schema" name >/dev/null 2>&1 || true
        gsettings reset "$schema" command >/dev/null 2>&1 || true
        gsettings reset "$schema" binding >/dev/null 2>&1 || true
    done

    case "$current" in
        "[]"|"[, ]"|"[ ]") current="@as []" ;;
    esac

    gsettings set "$KEYBINDINGS_SCHEMA" custom-keybindings "$current"
fi

echo "Uninstall complete."
