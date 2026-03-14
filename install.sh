#!/usr/bin/env bash
set -euo pipefail

REPO="SakuraMirai"
BASE_URL="https://raw.githubusercontent.com/TheRealNeoShade/SakuraMirai/main"

WAYBAR_DIR="$HOME/.config/waybar"
HYPRIDLE_DIR="$HOME/.config/hypridle"
WVKBD_DIR="$HOME/.config/wvkbd"

echo "====================================="
echo "   Installing SakuraMirai Waybar     "
echo "====================================="

backup_and_prepare() {
    local dir="$1"

    if [ -d "$dir" ]; then
        echo "Backing up $dir -> ${dir}.bak"
        mv "$dir" "${dir}.bak.$(date +%s)"
    fi

    mkdir -p "$dir"
}

install_packages() {

    echo "Checking packages..."

    sudo pacman -S --needed waybar hypridle ttf-jetbrains-mono-nerd curl

    if ! command -v wvkbd >/dev/null 2>&1; then
        echo "Installing wvkbd from AUR..."

        if command -v yay >/dev/null 2>&1; then
            yay -S --needed wvkbd
        elif command -v paru >/dev/null 2>&1; then
            paru -S --needed wvkbd
        else
            echo "❌ No AUR helper found."
            echo "Install yay or paru first."
            exit 1
        fi
    fi
}

download() {
    local url="$1"
    local output="$2"

    echo "Downloading $(basename "$output")..."
    curl -fsSL "$url" -o "$output"
}

install_files() {

    echo "Installing Waybar configs..."

    download "$BASE_URL/waybar/SakuraMirai_V1/config.jsonc" "$WAYBAR_DIR/config_v1.jsonc"
    download "$BASE_URL/waybar/SakuraMirai_V1/style.css" "$WAYBAR_DIR/style_v1.css"

    download "$BASE_URL/waybar/SakuraMirai_V2/config.jsonc" "$WAYBAR_DIR/config_v2.jsonc"
    download "$BASE_URL/waybar/SakuraMirai_V2/style.css" "$WAYBAR_DIR/style_v2.css"

    download "$BASE_URL/waybar/SakuraMirai_V3/config.jsonc" "$WAYBAR_DIR/config_v3.jsonc"
    download "$BASE_URL/waybar/SakuraMirai_V3/style.css" "$WAYBAR_DIR/style_v3.css"

    download "$BASE_URL/waybar/SakuraMirai_V4/config.jsonc" "$WAYBAR_DIR/config_v4.jsonc"
    download "$BASE_URL/waybar/SakuraMirai_V4/style.css" "$WAYBAR_DIR/style_v4.css"

    echo "Installing hypridle toggle..."
    download "$BASE_URL/scripts/hypridle.sh" "$HYPRIDLE_DIR/hypridle.sh"
    chmod +x "$HYPRIDLE_DIR/hypridle.sh"

    echo "Installing wvkbd toggle..."
    download "$BASE_URL/scripts/toggle.sh" "$WVKBD_DIR/toggle.sh"
    chmod +x "$WVKBD_DIR/toggle.sh"
}

# Prepare directories
backup_and_prepare "$WAYBAR_DIR"
backup_and_prepare "$HYPRIDLE_DIR"
backup_and_prepare "$WVKBD_DIR"

# Install dependencies
install_packages

# Install configs
install_files

echo ""
echo "✅ SakuraMirai installation complete!"
echo ""
echo "Restart Waybar with:"
echo "pkill waybar && waybar &"
echo ""
