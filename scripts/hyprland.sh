
#!/bin/bash

$helper -Sy --needed hyprland hyprcursor xdg-desktop-portal-hyprland \
hyprpaper hypridle hyprlock hyprlang hyprutils hyprwayland-scanner xwaylandvideobridge

$helper -Sy --needed kitty kitty-shell-integration kitty-terminfo foot thunar file-roller rofi-wayland waybar \
network-manager-applet swaync swww gammastep blueman wl-clipboard nwg-look \
network-manager-applet btop cliphist bat eza fastfetch networkmanager neovim vlc mpv papirus-folders-git \
papirus-icon-theme pavucontrol power-profiles-daemon ripgrep feh qt6ct kvantum thunar-archive-plugin \
thunar-volman wev wireplumber zoxide fzf wlr-randr swappy grim slurp ttf-jetbrains-mono-nerd

sleep 1
cd ~/m57-dots-install
