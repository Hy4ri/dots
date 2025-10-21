#!/usr/bin/env bash

# link from dots to .config

# Vars
config="$HOME/.config"
if [ -d "$HOME/Documents/Projects/dots" ]; then
  dots="$HOME/Documents/Projects/dots"
else
  dots="$HOME/dots"
fi

echo "Linking ..."

# zshrc
rm $HOME/.zshrc
ln -s $dots/.zshrc $HOME/.zshrc

# zprofile
rm $HOME/.zprofile
ln -s $dots/.zprofile $HOME/.zprofile

# hyprland
rm -rf $config/hypr
ln -s $dots/.config/hypr $config/hypr

# foot
rm -rf $config/foot
ln -s $dots/.config/foot $config/foot

# rofi
rm -rf $config/rofi
ln -s $dots/.config/rofi $config/rofi

# waybar
rm -rf $config/waybar
ln -s $dots/.config/waybar $config/waybar

# dunst
rm -rf $config/dunst
ln -s $dots/.config/dunst $config/dunst

# yazi
rm -rf $config/yazi
ln -s $dots/.config/yazi $config/yazi

# niri
rm -rf $config/niri
ln -s $dots/.config/niri $config/niri

# nvim
rm -rf $config/nvim
ln -s $dots/.config/nvim $config/nvim

# tmux
rm $HOME/.tmux.conf
ln -s $dots/.tmux.conf $HOME/.tmux.conf

echo "Done :)"
