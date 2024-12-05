#!/bin/bash

$helper -Sy --needed alacritty bash-completion bat bc bitwarden brightnessctl btop cartridges cliphist curl \
dua-cli duf egl-wayland eza fastfetch feh ffmpegthumbnailer file-roller foot gammastep gamemode grim gvfs \
gvfs-google gvfs-mtp heroic-games-launcher-bin hwinfo inxi intel-ucode jq kvantum lshw lutris man-db man-pages mpv \
mpv-mpris neovim network-manager-applet nwg-look obs-studio openrgb pacman-contrib pamixer papirus-icon-theme \
pavucontrol pipewire-alsa playerctl power-profiles-daemon qalculate-gtk qt5ct qt6-svg qt6ct rofi-wayland scrcpy \
slurp swappy swaync termdown tesseract-data-ara tesseract-data-eng thunar thunar-archive-plugin thunar-volman \
tty-clock vesktop vivaldi vivaldi-ffmpeg-codecs vivaldi-widevine vlc waybar wget wl-clipboard xdg-user-dirs \
xdg-utils xorg-xhost xwaylandvideobridge yad yt-dlp zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps zed \
zoxide

sleep 2

sudo curl -sL github.com/justchokingaround/jerry/raw/main/jerry.sh -o /usr/local/bin/jerry &&
sudo chmod +x /usr/local/bin/jerry


sleep 1
cd ~/m57-dots-install
