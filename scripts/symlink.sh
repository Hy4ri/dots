#!/usr/bin/env bash

# link from dots to .config

# Vars
config="$HOME/.config"
if [ -d "$HOME/Documents/Projects/dots" ]; then
    dots="$HOME/Documents/Projects/dots"
else
    dots="$HOME/m57-dots-install"
fi

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

# gammastep
rm -rf $config/gammastep
ln -s $dots/.config/gammastep $config/gammastep

# rofi
rm -rf $config/rofi
ln -s $dots/.config/rofi $config/rofi

# swaync
rm -rf $config/swaync
ln -s $dots/.config/swaync $config/swaync

# waybar
rm -rf $config/waybar
ln -s $dots/.config/waybar $config/waybar

# nvim
rm -rf $config/nvim
ln -s $dots/.config/nvim $config/nvim

# tmux
rm $HOME/.tmux.conf
ln -s $dots/.tmux.conf $HOME/.tmux.conf

# tmux plugins
rm -rf $HOME/.tmux
ln -s $dots/.tmux $HOME/.tmux
