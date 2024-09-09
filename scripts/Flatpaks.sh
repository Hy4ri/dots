#!/bin/bash

$helper -Sy --noconfirm --needed flatpak

flatpak install --user -y com.github.tchx84.Flatseal com.vivaldi.Vivaldi dev.vencord.Vesktop org.gimp.GIMP \
org.onlyoffice.desktopeditors it.mijorus.smile com.visualstudio.code com.spotify.Client

sleep 3
cd ~/m57-dots-install
