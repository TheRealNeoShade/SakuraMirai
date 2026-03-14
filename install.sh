#!/usr/bin/env bash
set -euo pipefail

REPO="SakuraMirai"
BASE_URL="https://raw.githubusercontent.com/TheRealNeoShade/SakuraMirai/main"

# Use config parent directories to ensure we don't break other things
WAYBAR_DIR="$HOME/.config/waybar"
HYPRIDLE_DIR="$HOME/.config/hypridle"
WVKBD_DIR="$HOME/.config/wvkbd"

echo "====================================="
echo "   Installing SakuraMirai Configs    "
echo "====================================="

backup_and_prepare() {
    local dir="$1"
    if [ -d "$dir" ]; then
        echo "Backing up $dir -> ${dir}.bak"
        mv "$dir" "${dir}.bak.$(date +%s)"
    fi
    # Ensure the directory exists before downloading files into it
    mkdir -p "$dir"
}

install_packages() {
    echo "Checking packages..."
    # --needed prevents re-installing things you already have
    sudo pacman -S --needed waybar hypridle ttf-jetbrains-mono-nerd curl --noconfirm

    if ! command -v wvkbd >/dev/null 2>&1; then
        echo "Installing wvkbd from AUR..."
        if command -v yay >/dev/null 2>&1; then
            yay -S --needed wvkbd --noconfirm
        elif command -v paru >/dev/null 2>&1; then
            paru -S --needed wvkbd --noconfirm
        else
            echo "❌ No AUR helper found. Please install wvkbd manually."
            # We don't exit here so the rest of the config still installs
        fi
    fi
}

download() {
    local url="$1"
    local output="$2"
    
    # Create the parent directory of the file just in case
    mkdir -p "$(dirname "$output")"
    
    echo "Downloading $(basename "$output")..."
    if ! curl -fsSL "$url" -o "$output"; then
        echo "⚠️  Failed to download $url"
        return 1
    fi
}

install_files() {
    echo "Installing Waybar configs..."
    # Downloading versions
    for v in V1 V2 V3 V4; do
        download "$BASE_URL/waybar/SakuraMirai_$v/config.jsonc" "$WAYBAR_DIR/config_${v,,}.jsonc"
        download "$BASE_URL/waybar/SakuraMirai_$v/style.css" "$WAYBAR_DIR/style_${v,,}.css"
    done

    echo "Installing scripts..."
    download "$BASE_URL/scripts/hypridle.sh" "$HYPRIDLE_DIR/hypridle.sh"
    chmod +x "$HYPRIDLE_DIR/hypridle.sh" || true

    download "$BASE_URL/scripts/toggle.sh" "$WVKBD_DIR/toggle.sh"
    chmod +x "$WVKBD_DIR/toggle.sh" || true
}

# --- Execution ---

# 1. Setup Directories
backup_and_prepare "$WAYBAR_DIR"
backup_and_prepare "$HYPRIDLE_DIR"
backup_and_prepare "$WVKBD_DIR"

# 2. Dependencies
install_packages

# 3. Files
install_files

echo -e "\n✅ SakuraMirai installation complete!"
echo "Note: Files are named config_v1.jsonc, etc."
echo "To use one, symlink it: ln -s $WAYBAR_DIR/config_v1.jsonc $WAYBAR_DIR/config"
