#!/bin/bash

sudo pacman -Sy --noconfirm --needed flatpak

flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install --user -y flathub com.github.tchx84.Flatseal com.vivaldi.Vivaldi dev.vencord.Vesktop org.gimp.GIMP \
org.onlyoffice.desktopeditors it.mijorus.smile com.visualstudio.code com.spotify.Client

sleep 3
cd ~/m57-dots-install
