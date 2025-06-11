# Hyprland Waybar in Arch linux Setup Script

This script automates the installation and setup of the Hyprland Wayland compositor along with a collection of essential applications and configurations to get you started with a functional, stylish Linux desktop environment.
You need to have yay.

> ⚠️ **Warning:** This script is intended to be run on a fresh Arch-based system. It assumes you have `yay` (AUR helper) installed. There is no error checking. Proceed with caution.
---
Reboot the machine to work properly
## Home page
![image](https://github.com/user-attachments/assets/566f4eed-4766-42dd-a1a1-20118b5643c4)



## 🚀 Features

The script will:

- Install **Hyprland** and essential Wayland utilities.
- Install utilities for system control (Wi-Fi, Bluetooth, volume, brightness, screenshots, etc.).#Brightness setting need to change based on the cpu and gpu. 
- Set up aesthetic components (Dracula theme, icons, nerd fonts).
- Copy preconfigured configuration files to your `~/.config` directory.
- Optionally add `fastfetch` and `starship` shell prompt to `.bashrc`.
- Optionally disable Wi-Fi powersave.
- Optionally start the Hyprland session.

---

## 📦 Packages Installed

Includes (but not limited to):

- **Core Environment:** `hyprland`, `waybar`, `kitty`, `swaybg`, `xdg-desktop-portal-hyprland`
- **Lock & Launch:** `swaylock-effects`, `wofi`, `wlogout`
- **UI & UX Tools:** `mako`, `thunar`, `dracula-gtk-theme`, `dracula-icons-git`
- **Fonts & Terminal Tools:** `ttf-jetbrains-mono-nerd`, `noto-fonts-emoji`, `starship`, `fastfetch`
- **System Tools:** `pamixer`, `brightnessctl`, `blueman`, `nm-applet`, `gvfs`, `python-requests`
- **Screenshot Tools:** `grim`, `slurp`, `swappy`
- **Other Applications:** `firefox`, `google-chrome`, `code`

---

## 📂 Configuration Files

The script will optionally copy your configuration files to `~/.config`:

- `hypr/`
- `kitty/`
- `waybar/`
- `mako/`
- `swaylock/`
- `wofi/`

It also ensures key scripts are marked as executable.

---

## 🔧 Keybindings Example (Hyprland)

```ini
Window button + spacebar = app drawer
Window button + f = fullscreen
Window button + q = terminal
Window button + x = close app

Brightness control is based on the gpu so this script is for amd but you can change it .
