#!/usr/bin/env bash

cat <<"EOF"


██╗   ██╗ █████╗ ██╗   ██╗
╚██╗ ██╔╝██╔══██╗╚██╗ ██╔╝
 ╚████╔╝ ███████║ ╚████╔╝
  ╚██╔╝  ██╔══██║  ╚██╔╝
   ██║   ██║  ██║   ██║
   ╚═╝   ╚═╝  ╚═╝   ╚═╝

EOF

cd ~/

if command -v yay &>/dev/null; then
  yay -Syu --noconfirm
else
  pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  yay -Syu --noconfirm
fi

cd ~/dots
