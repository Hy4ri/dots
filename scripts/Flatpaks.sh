#!/usr/bin/env bash

sudo pacman -Sy --noconfirm --needed flatpak

flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install --user flathub \
    com.github.tchx84.Flatseal \
    org.gimp.GIMP \
    ocom.spotify.Client \
    com.usebottles.bottles \
    io.github.flattool.Warehouse \
    it.mijorus.gearlever \
    com.obsproject.Studio

sudo flatpak override --filesystem=~/.themes
sudo flatpak override --filesystem=~/.icons

cd ~/dots
