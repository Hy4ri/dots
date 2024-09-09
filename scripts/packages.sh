#!/bin/bash

$helper -Sy --noconfirm --needed alacritty bitwarden bat flatpak gammastep gamemode gparted lutris man-db man-pages openrgb \
papirus-icon-theme feh power-profiles-daemon scrcpy timeshift thunar thunar-volman tumbler termdown \
ffmpegthumbnailer file-roller thunar-archive-plugin wev xwaylandvideobridge xorg-host zathura zathura-cb zathura-djvu \
zathura-language-server zathura-pdf-mupdf zathura-ps zoxide cliphist curl grim gvfs gvfs-mtp gvfs-google hypridle \
hyprlock hyprpaper inxi jq foot kvantum network-manager-applet pamixer pavucontrol pipewire-alsa playerctl \
qt5ct qt6ct qt6-svg rofi-wayland slurp swappy swaync waybar wget wl-clipboard xdg-user-dirs xdg-utils yad brightnessctl \
btop eza fastfetch vlc mpv mpv-mpris nvtop pacman-contrib neovim yt-dlp bash-completion bc bash-completion dua-cli duf \
egl-wayland fish fish-autopair fish-pure-prompt fisher hwinfo intel-ucode lshw nano-syntax-highlighting obs-studio openssh \
w3m nwg-look

sleep 2

sudo curl -sL github.com/justchokingaround/jerry/raw/main/jerry.sh -o /usr/local/bin/jerry &&
sudo chmod +x /usr/local/bin/jerry


sleep 1
cd ~/m57-dots-install
