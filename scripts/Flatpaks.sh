#!/bin/bash

sudo pacman -Sy --noconfirm --needed flatpak

flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install --user -y flathub com.github.tchx84.Flatseal dev.vencord.Vesktop org.gimp.GIMP \
org.onlyoffice.desktopeditors com.spotify.Client com.rafaelmardojai.Blanket com.usebottles.bottles \
io.github.flattool.Warehouse it.mijorus.gearlever \

sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --filesystem=$HOME/.icons

sleep 3
cd ~/m57-dots-install
