#!/usr/bin/env bash

cat <<"EOF"

██████╗  █████╗ ██████╗ ██╗   ██╗
██╔══██╗██╔══██╗██╔══██╗██║   ██║
██████╔╝███████║██████╔╝██║   ██║
██╔═══╝ ██╔══██║██╔══██╗██║   ██║
██║     ██║  ██║██║  ██║╚██████╔╝
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

EOF

cd ~/

if command -v paru &>/dev/null; then
  paru -Syu --noconfirm
else
  sudo pacman -S base-devel
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si --noconfirm
  sleep 1
  paru -Syu --noconfirm
fi

cd ~/dots
