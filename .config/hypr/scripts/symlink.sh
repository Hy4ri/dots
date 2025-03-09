#!/usr/bin/env bash

# link from dots to .config

# zshrc

rm $HOME/.zshrc
ln -s $HOME/Documents/Projects/dots/.zshrc $HOME/.zshrc


# hyprland

rm -rf $HOME/.config/hypr
ln -s $HOME/Documents/Projects/dots/.config/hypr $HOME/.config/hypr

# foot

rm -rf $HOME/.config/foot
ln -s $HOME/Documents/Projects/dots/.config/foot $HOME/.config/foot

# gammastep

rm -rf $HOME/.config/gammastep
ln -s $HOME/Documents/Projects/dots/.config/gammastep $HOME/.config/gammastep

# rofi

rm -rf $HOME/.config/rofi
ln -s $HOME/Documents/Projects/dots/.config/rofi $HOME/.config/rofi

# swaync

rm -rf $HOME/.config/swaync
ln -s $HOME/Documents/Projects/dots/.config/swaync $HOME/.config/swaync

# waybar

rm -rf $HOME/.config/waybar
ln -s $HOME/Documents/Projects/dots/.config/waybar $HOME/.config/waybar
