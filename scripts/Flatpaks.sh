#!/usr/bin/env bash

flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install --user flathub \
  com.github.tchx84.Flatseal \
  ocom.spotify.Client \
  io.github.flattool.Warehouse \
  it.mijorus.gearlever \
  com.obsproject.Studio

sudo flatpak override --filesystem=~/.themes
sudo flatpak override --filesystem=~/.icons
sudo faltpak override --env=GTK_THEME=theme

cd ~/dots
