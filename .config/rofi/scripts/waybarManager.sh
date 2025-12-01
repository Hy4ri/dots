#!/usr/bin/env bash
set -euo pipefail

# Directories
WAYBAR_LAYOUTS="$HOME/.config/waybar/configs"
WAYBAR_STYLES="$HOME/.config/waybar/style"
WAYBAR_CONFIG="$HOME/.config/waybar/config.jsonc"
WAYBAR_STYLE_FILE="$HOME/.config/waybar/style.css"
SCRIPTSDIR="$HOME/.config/hypr/scripts"

# Helper: Restart Waybar
restart_waybar() {
  if pgrep -x "waybar" >/dev/null; then
    pkill waybar
    sleep 0.1
  fi
  "${SCRIPTSDIR}/refresh.sh" &
  notify-send "Waybar" "Restarted"
}

# Helper: Apply Config
apply_config() {
  ln -sf "$WAYBAR_LAYOUTS/$1" "$WAYBAR_CONFIG"
  restart_waybar
  notify-send "Waybar" "Layout applied: $1"
}

# Helper: Apply Style
apply_style() {
  ln -sf "$WAYBAR_STYLES/$1.css" "$WAYBAR_STYLE_FILE"
  restart_waybar
  notify-send "Waybar" "Style applied: $1"
}

# Menu Functions
menu_layout() {
  options=$(find "$WAYBAR_LAYOUTS" -maxdepth 1 -type f -exec basename {} \; | sort)
  options="no panel"$'\n'"$options"
  
  choice=$(echo "$options" | rofi -dmenu -p "Select Layout" -i)
  
  if [[ -n "$choice" ]]; then
    if [[ "$choice" == "no panel" ]]; then
      pgrep -x "waybar" && pkill waybar || true
    else
      apply_config "$choice"
    fi
  fi
}

menu_style() {
  options=$(find "$WAYBAR_STYLES" -maxdepth 1 -type f -name '*.css' -exec basename {} .css \; | sort)
  
  choice=$(echo "$options" | rofi -dmenu -p "Select Style" -i)
  
  if [[ -n "$choice" ]]; then
    apply_style "$choice"
  fi
}

# Main Menu
MENU_ITEMS=(
  "Change Layout|menu_layout"
  "Change Style|menu_style"
  "Restart Waybar|restart_waybar"
)

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "Waybar Settings" -i)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
