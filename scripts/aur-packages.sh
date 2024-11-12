#!/bin/bash

$helper -Sy --noconfirm --needed cartridges heroic-games-launcher-bin hyprprop-git hyprshade-git mangal-bin \
normcap papirus-folders-git qview spicetify-cli tty-clock vesktop waypaper aylurs-gtk-shell imagemagick cava \
upscayl-bin visual-studio-code-bin tesseract-data-ara tesseract-data-eng

$helper -Sy --noconfirm --needed ds4drv game-devices-udev dualsensectl xone-dkms

sleep 1
cd ~/m57-dots-install
