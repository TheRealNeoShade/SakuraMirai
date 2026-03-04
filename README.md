# 🌸 SakuraMirai Waybar

Minimal Hyprland Waybar Theme with Japanese Cyber aesthetics.

---

## ✨ Features

- hidden sliding menu for extra utilities and 3 customized button for your top apps!
- Hypridle toggle (Coffee Mode)!
- wvkbd toggle (On-Screen Keyboard)!
- Auto installer!
- Backup protection!

---

## ⛏ Installation

```
bash <(curl -fsSL https://raw.githubusercontent.com/TheRealNeoShade/SakuraMirai/main/install.sh)
```
> Manual Installation at the end of README.

---

## 📷 Preview

### SakuraMirai_V1

![SakuraMirai_V1](/preview/V1.png)

### SakuraMirai_V2

![SakuraMirai_V2](/preview/V2.png)

## 📖 License

This project is licensed under CC BY-NC 4.0.

You may use, modify and share freely.
Commercial selling is NOT allowed.

## 🛠 Manual Installation (Arch Linux)

1. Clone the repository:

```bash
git clone https://github.com/TheRealNeoShade/SakuraMirai.git
cd SakuraMirai
```

2. Install required packages:
```
sudo pacman -S --needed waybar hypridle ttf-jetbrains-mono-nerd
```
3. Install wvkbd from AUR:
```
yay -S --needed wvkbd
```
- or
```
paru -S --needed wvkbd
```
4. Backup existing configs (recommended):
```
mv ~/.config/waybar ~/.config/waybar.bak 2>/dev/null
mv ~/.config/hypridle ~/.config/hypridle.bak 2>/dev/null
mv ~/.config/wvkbd ~/.config/wvkbd.bak 2>/dev/null
```
5. Create directories:
```
mkdir -p ~/.config/waybar
mkdir -p ~/.config/hypridle
mkdir -p ~/.config/wvkbd
```
6. Copy Waybar V1:
```
cp -r waybar/SakuraMirai_V1/* ~/.config/waybar/
```
- OR Copy Waybar V2:
```
cp -r waybar/SakuraMirai_V2/* ~/.config/waybar/
```
7. Copy toggle scripts:
```
cp scripts/hypridle.sh ~/.config/hypridle/hypridle.sh
cp scripts/toggle.sh ~/.config/wvkbd/toggle.sh
```
8. Make scripts executable:
```
chmod +x ~/.config/hypridle/hypridle.sh
chmod +x ~/.config/wvkbd/toggle.sh
```
9. Restart Waybar:
```
pkill waybar && waybar &
```

