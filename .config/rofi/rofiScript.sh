#!/usr/bin/env bash

# Style
dir="$HOME/.config/rofi/launchers/"
theme='style'
scripts="$HOME/.config/rofi/scripts"

# Menu labels
MENU="📝 Notes\n👾 Games\n💡 Brightness\n🔆 Weather\n💻 Pc Stats\n🟥🟩🟦 RGB Profiles\n🎨 Waybar Theme\n🎨 Waybar Layout"

CHOICE=$(echo -e "$MENU" | rofi -dmenu -p "Choose Script" -theme ${dir}/${theme}.rasi)

case "$CHOICE" in
"🟥🟩🟦 RGB Profiles") $scripts/rgb_profiles.sh ;;
"🔆 Weather") $scripts/weather.sh ;;
"🎨 Waybar Theme") $scripts/WaybarStyles.sh ;;
"🎨 Waybar Layout") $scripts/WaybarLayout.sh ;;
"👾 Games") $scripts/game_launcher.sh ;;
"💻 Pc Stats") $scripts/system.sh ;;
"💡 Brightness") $scripts/brightness.sh ;;
"📝 Notes") $scripts/notes.sh ;;
esac
