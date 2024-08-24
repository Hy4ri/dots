#!/bin/bash

$helper -Sy --noconfirm --needed wayfire wayfire-plugins-extra wcm wf-config wf-shell xwaylandvideobridge

$helper -Sy --noconfirm --needed kitty kitty-shell-integration kitty-terminfo foot thunar file-roller rofi-wayland waybar \
firefox network-manager-applet swaync swww gammastep blueman wl-clipboard mousepad lxapperance \
network-manager-applet btop cliphist bat eza fastfetc galculato networkmanage neovim vlc mpv papirus-folders-git \
papirus-icon-theme pavucontrol power-profiles-daemon ripgrep qview qt6ct kvantum thunar-archive-plugin \
thunar-volman waypaper wev wireplumber zoxide fzf wlr-randr swappy grim slurp

clear
sleep 1
cd ~/m57-dots-install
