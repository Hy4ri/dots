#!/usr/bin/env bash
set -euo pipefail

# Define menu items as "Label|Function Name"
MENU_ITEMS=(
  " Lock|lock"
  "󰒲 Suspend|suspend"
  " Logout|logout"
  " Reboot|reboot"
  " Shutdown|shutdown"
)

# Confirmation CMD
confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
    -theme-str 'mainbox {children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Confirmation'
}

# Ask for confirmation
confirm_exit() {
  echo -e "\n" | confirm_cmd
}

# Functions
lock() {
  loginctl lock-session
}

suspend() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "" ]]; then
    systemctl suspend
  fi
}

logout() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "" ]]; then
    loginctl kill-session "$XDG_SESSION_ID"
  fi
}

reboot() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "" ]]; then
    systemctl reboot
  fi
}

shutdown() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "" ]]; then
    systemctl poweroff -i
  fi
}

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "Powermenu" -i)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
