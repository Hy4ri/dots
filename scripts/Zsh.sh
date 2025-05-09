#!/bin/bash

$helper -Sy --noconfirm --needed zsh zsh-completions fzf curl git
$hlper -Sy --needed eza tty-clock yt-dlp ripgrep dua-cli termdown zoxide fastfetch
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sleep 1

git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

sleep 1

chsh -s /bin/zsh

sleep 1
cd ~/m57-dots-install
