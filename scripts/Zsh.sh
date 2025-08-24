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

# plugins

curl -L git.io/antigen >antigen.zsh

sleep 1

# change shell

chsh -s /bin/zsh

cd ~/dots
