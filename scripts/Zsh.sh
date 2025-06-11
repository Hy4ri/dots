#!/usr/bin/env bash

$helper -Sy --noconfirm --needed \
  zsh \
  fzh \
  curl \
  git
$helper -Sy --needed \
  eza \
  yt-dlp \
  ripgrep \
  dua-cli \
  termdown \
  zoxide \
  fastfetch

sleep 1
# Ohmyzsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

sleep 1

# change shell

chsh -s /bin/zsh

cd ~/dots
