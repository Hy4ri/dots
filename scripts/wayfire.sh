#!/bin/bash

$helper -Sy --noconfirm --needed wayfire wayfire-plugins-extra wcm wf-config wf-shell xwaylandvideobridge swww

$helper -Sy --needed kitty thunar file-roller rofi-wayland waybar \
network-manager-applet swaync gammastep blueman wl-clipboard nwg-look \
cliphist networkmanager papirus-folders-git \
papirus-icon-theme pavucontrol power-profiles-daemon qt6ct kvantum thunar-archive-plugin \
wev wireplumber fzf swappy grim slurp ttf-jetbrains-mono-nerd

sleep 1
cd ~/m57-dots-install
