#!/bin/bash

$helper -Sy --needed cartridges heroic-games-launcher-bin mangal-bin \
normcap papirus-folders-git qview spicetify-cli tty-clock vesktop hyprwall-bin imagemagick \
upscayl-bin tesseract-data-ara tesseract-data-eng

$helper -Sy --noconfirm --needed ds4drv game-devices-udev dualsensectl xone-dkms

sleep 1
cd ~/m57-dots-install
