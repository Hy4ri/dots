#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for waybar layout or configs

set -euo pipefail
IFS=$'\n\t'

# Define directories
waybar_layouts="$HOME/.config/waybar/configs"
waybar_config="$HOME/.config/waybar/config.jsonc"
SCRIPTSDIR="$HOME/.config/hypr/scripts"
rofi_theme="$HOME/.config/rofi/launchers/style.rasi"

# Function to display menu options
menu() {
  options=()
  while IFS= read -r file; do
    options+=("$(basename "$file")")
  done < <(find "$waybar_layouts" -maxdepth 1 -type f -exec basename {} \; | sort)

  printf '%s\n' "${options[@]}"
}

# Apply selected configuration
apply_config() {
  ln -sf "$waybar_layouts/$1" "$waybar_config"
  restart_waybar_if_needed
}

# Restart Waybar
restart_waybar_if_needed() {
  if pgrep -x "waybar" >/dev/null; then
    pkill waybar
    sleep 0.1 # Delay for Waybar to completely terminate
  fi
  "${SCRIPTSDIR}/Refresh.sh" &
}

# Main function
main() {
  choice=$(menu | rofi -dmenu -theme "$rofi_theme")

  if [[ -z "$choice" ]]; then
    echo "No option selected. Exiting."
    exit 0
  fi

  case $choice in
  "no panel")
    pgrep -x "waybar" && pkill waybar || true
    ;;
  *)
    apply_config "$choice"
    ;;
  esac
}

# Kill Rofi if already running before execution
if pgrep -x "rofi" >/dev/null; then
  pkill rofi
  exit 0
fi

main
