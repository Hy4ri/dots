#!/usr/bin/env bash
set -euo pipefail

SCRIPTS="$HOME/.config/rofi/scripts"

# Define menu items as "Label|Command"
MENU_ITEMS=(
  "⏸️ Powermenu|$SCRIPTS/powermenu.sh"
  "📝 Notes|$SCRIPTS/notes.sh"
  "  HyprEdit|$SCRIPTS/hypredit.sh"
  "󱄅  NixEdit|$SCRIPTS/nixedit.sh"
  "⌚ Timer|$SCRIPTS/timer.sh"
  "  Tasks|$SCRIPTS/tasks.sh"
  "🎥 Screen Recorder|$SCRIPTS/screenrecord.sh"
  "🔍 Quick Search|$SCRIPTS/quicksearch.sh"
  "👾 Games|$SCRIPTS/game_launcher.sh"
  "⚙️ Hyprsettings|$SCRIPTS/hyprsettings.sh"
  "⚙️ Projects|$SCRIPTS/projects.sh"
  "🛜 wifi|$SCRIPTS/wifi.sh"
  "📃 Mans|$SCRIPTS/man.sh"
  "🔧 Yad|$SCRIPTS/yad.sh"
  "💡 Brightness|$SCRIPTS/brightness.sh"
  "🔆 Weather|$SCRIPTS/weather.sh"
  "🌡️ Temprature|$SCRIPTS/temps.sh"
  "💻 Pc Stats|$SCRIPTS/system.sh"
  "🎨 Waybar Settings|$SCRIPTS/waybarManager.sh"
  "🟥🟩🟦 RGB Profiles|$SCRIPTS/rgb_profiles.sh"
)

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "Choose Script" -i)

# Match selection and execute command
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label cmd <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$cmd"
    exit 0
  fi
done

exit 1
