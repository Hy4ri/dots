#!/usr/bin/env bash

# Style
dir="$HOME/.config/rofi/launchers/type-3"
theme='style-5'

# Menu labels
MENU="💡 RGB Profiles\n🔆 Weather\n🎨 Waybar Theme\n🎨 Waybar Layout"

CHOICE=$(echo -e "$MENU" | rofi -dmenu -p "Choose Script" -theme ${dir}/${theme}.rasi)

case "$CHOICE" in
    "💡 RGB Profiles") ~/.config/rofi/scripts/rgb_profiles.sh ;;
    "🔆 Weather") ~/.config/rofi/scripts/weather.sh ;;
    "🎨 Waybar Theme") ~/.config/rofi/scripts/WaybarStyles.sh ;;
    "🎨 Waybar Layout") ~/.config/rofi/scripts/WaybarLayout.sh ;;
esac
