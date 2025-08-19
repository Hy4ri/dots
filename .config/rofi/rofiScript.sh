#!/usr/bin/env bash

# Style
dir="$HOME/.config/rofi/launchers/"
theme='style'
scripts="$HOME/.config/rofi/scripts"

# Menu labels
MENU="📝 Notes\n⌚ Timer\n👾 Games\n🔧 Yad\n💡 Brightness\n🔆 Weather\n💻 Pc Stats\n🎨 Waybar Theme\n🎨 Waybar Layout"

CHOICE=$(echo -e "$MENU" | rofi -dmenu -p "Choose Script" -i -theme ${dir}/${theme}.rasi)

case "$CHOICE" in
"🟥🟩🟦 RGB Profiles") $scripts/rgb_profiles.sh ;;
"🔆 Weather") $scripts/weather.sh ;;
"🎨 Waybar Theme") $scripts/WaybarStyles.sh ;;
"🎨 Waybar Layout") $scripts/WaybarLayout.sh ;;
"👾 Games") $scripts/game_launcher.sh ;;
"💻 Pc Stats") $scripts/system.sh ;;
"💡 Brightness") $scripts/brightness.sh ;;
"📝 Notes") $scripts/notes.sh ;;
"⌚ Timer") $scripts/timer.sh ;;
"🎥 Screen Recorder") $scripts/screenrecord.sh ;;
"🔧 Yad") $scripts/yad.sh ;;
esac
