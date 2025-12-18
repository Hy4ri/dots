#!/usr/bin/env bash

flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install --user flathub \
  com.spotify.Client \

sudo flatpak override --filesystem=~/.themes
sudo flatpak override --filesystem=~/.icons
sudo flatpak override --env=GTK_THEME=theme

cd ~/dots
