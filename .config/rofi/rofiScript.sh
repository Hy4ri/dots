#!/usr/bin/env bash

# Style
scripts="$HOME/.config/rofi/scripts"

# Menu labels
MENU="⏸️ Powermenu\n📝 Notes\n  HyprEdit\n󱄅  NixEdit\n⚙️ Projects\n⌚ Timer\n👾 Games\n🎥 Screen Recorder\n🛜 wifi\n📃 Mans\n🔧 Yad\n💡 Brightness\n🔆 Weather\n💻 Pc Stats\n🎨 Waybar Theme\n🎨 Waybar Layout"

CHOICE=$(echo -e "$MENU" | rofi -dmenu -p "Choose Script")

case "$CHOICE" in
"🟥🟩🟦 RGB Profiles") $scripts/rgb_profiles.sh ;;
"🔆 Weather") $scripts/weather.sh ;;
"🎨 Waybar Theme") $scripts/waybarStyles.sh ;;
"🎨 Waybar Layout") $scripts/waybarLayout.sh ;;
"👾 Games") $scripts/game_launcher.sh ;;
"💻 Pc Stats") $scripts/system.sh ;;
"💡 Brightness") $scripts/brightness.sh ;;
"📝 Notes") $scripts/notes.sh ;;
"⌚ Timer") $scripts/timer.sh ;;
"🎥 Screen Recorder") $scripts/screenrecord.sh ;;
"🔧 Yad") $scripts/yad.sh ;;
"📃 Mans") $scripts/man.sh ;;
"⏸️ Powermenu") $scripts/powermenu.sh ;;
"  HyprEdit") $scripts/hypredit.sh ;;
"󱄅  NixEdit") $scripts/nixedit.sh ;;
"🛜 wifi") $scripts/wifi.sh ;;
"⚙️ Projects") $scripts/projects.sh ;;
esac
