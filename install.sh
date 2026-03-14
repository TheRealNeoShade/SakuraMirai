#!/usr/bin/env bash
set -euo pipefail

# Configuration
REPO_URL="https://github.com/TheRealNeoShade/SakuraMirai.git"
TEMP_DIR="/tmp/sakuramirai_install"

WAYBAR_DIR="$HOME/.config/waybar"
HYPRIDLE_DIR="$HOME/.config/hypridle"
WVKBD_DIR="$HOME/.config/wvkbd"

echo "====================================="
echo "   Installing SakuraMirai via Git    "
echo "====================================="

# 1. Install Dependencies First
echo "Checking dependencies..."
sudo pacman -S --needed git waybar hypridle ttf-jetbrains-mono-nerd curl --noconfirm

# 2. Clean up any previous failed attempts and Clone
echo "Cloning repository..."
rm -rf "$TEMP_DIR"
git clone --depth 1 "$REPO_URL" "$TEMP_DIR"

# 3. Create/Backup Target Directories
prepare_dir() {
    local dir="$1"
    if [ -d "$dir" ]; then
        echo "Backing up $dir..."
        mv "$dir" "${dir}.bak.$(date +%s)"
    fi
    mkdir -p "$dir"
}

prepare_dir "$WAYBAR_DIR"
prepare_dir "$HYPRIDLE_DIR"
prepare_dir "$WVKBD_DIR"

# 4. Copy Files from the Cloned Repo
echo "Moving files to .config..."

# Copy Waybar versions (Assuming structure is waybar/SakuraMirai_V1/...)
if [ -d "$TEMP_DIR/waybar" ]; then
    cp -r "$TEMP_DIR/waybar/"* "$WAYBAR_DIR/"
    echo "✅ Waybar configs copied."
fi

# Copy Scripts
if [ -f "$TEMP_DIR/scripts/hypridle.sh" ]; then
    cp "$TEMP_DIR/scripts/hypridle.sh" "$HYPRIDLE_DIR/"
    chmod +x "$HYPRIDLE_DIR/hypridle.sh"
    echo "✅ Hypridle script copied."
fi

if [ -f "$TEMP_DIR/scripts/toggle.sh" ]; then
    cp "$TEMP_DIR/scripts/toggle.sh" "$WVKBD_DIR/"
    chmod +x "$WVKBD_DIR/toggle.sh"
    echo "✅ wvkbd toggle copied."
fi

# 5. Cleanup
rm -rf "$TEMP_DIR"

echo -e "\n✨ Installation complete!"
echo "Your waybar configs are now in: $WAYBAR_DIR"
echo "Check them out with: ls $WAYBAR_DIR"
