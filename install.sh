#!/usr/bin/env bash
set -e

REPO="SakuraMirai"
BASE_URL="https://raw.githubusercontent.com/TheRealNeoShade/SakuraMirai/main"

WAYBAR_DIR="$HOME/.config/waybar"
HYPRIDLE_DIR="$HOME/.config/hypridle"
WVKBD_DIR="$HOME/.config/wvkbd"

echo "====================================="
echo "   Installing SakuraMirai Waybars    "
echo "====================================="

backup_and_prepare() {
    if [ -d "$1" ]; then
        echo "Backing up $1 -> $1.bak"
        mv "$1" "$1.bak"
    fi
    mkdir -p "$1"
}

install_packages() {

    echo "Checking packages..."

    command -v waybar >/dev/null || sudo pacman -S --needed waybar
    command -v hypridle >/dev/null || sudo pacman -S --needed hypridle
    sudo pacman -S --needed ttf-jetbrains-mono-nerd

    if ! command -v wvkbd >/dev/null; then
        echo "Installing wvkbd from AUR..."
        if command -v yay >/dev/null; then
            yay -S --needed wvkbd
        elif command -v paru >/dev/null; then
            paru -S --needed wvkbd
        else
            echo "No AUR helper found. Install yay or paru first."
            exit 1
        fi
    fi
}

install_files() {

    echo "Installing Waybar V1 and V2..."

    curl -s "$BASE_URL/waybar/SakuraMirai_V1/config.jsonc" -o "$WAYBAR_DIR/config_v1.jsonc"
    curl -s "$BASE_URL/waybar/SakuraMirai_V1/style.css" -o "$WAYBAR_DIR/style_v1.css"

    curl -s "$BASE_URL/waybar/SakuraMirai_V2/config.jsonc" -o "$WAYBAR_DIR/config_v2.jsonc"
    curl -s "$BASE_URL/waybar/SakuraMirai_V2/style.css" -o "$WAYBAR_DIR/style_v2.css"
    
    curl -s "$BASE_URL/waybar/SakuraMirai_V3/config.jsonc" -o "$WAYBAR_DIR/config_v3.jsonc"
    curl -s "$BASE_URL/waybar/SakuraMirai_V3/style.css" -o "$WAYBAR_DIR/style_v3.css"
    
    curl -s "$BASE_URL/waybar/SakuraMirai_V4/config.jsonc" -o "$WAYBAR_DIR/config_v4.jsonc"
    curl -s "$BASE_URL/waybar/SakuraMirai_V4/style.css" -o "$WAYBAR_DIR/style_v4.css"

    echo "Installing hypridle toggle..."
    curl -s "$BASE_URL/scripts/hypridle.sh" -o "$HYPRIDLE_DIR/hypridle.sh"
    chmod +x "$HYPRIDLE_DIR/toggle.sh"

    echo "Installing wvkbd toggle..."
    curl -s "$BASE_URL/scripts/toggle.sh" -o "$WVKBD_DIR/toggle.sh"
    chmod +x "$WVKBD_DIR/toggle.sh"
}

backup_and_prepare "$WAYBAR_DIR"
backup_and_prepare "$HYPRIDLE_DIR"
backup_and_prepare "$WVKBD_DIR"

install_packages
install_files

echo ""
echo "SakuraMirai installation complete!"
echo "Restart Waybar:"
echo "pkill waybar && waybar &"
echo ""
