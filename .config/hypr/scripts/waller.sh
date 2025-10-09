#!/usr/bin/env bash

Select_wallpaper() {
  local wall
  wall=$(for a in ~/Pictures/wallpapers/*.png; do echo -en "$a\0icon\x1f$a\n"; done | rofi -dmenu -config ~/.config/rofi/waller/config.rasi -theme ~/.config/rofi/waller/style.rasi)
  if [[ -n "$wall" && -f "$wall" ]]; then
    swww img "$wall" --outputs eDP-1 --transition-type none --transition-duration 0
  else
    echo "No wallpaper selected or invalid file."
  fi
}

Select_wallpaper_wal() {
  local wall
  wall=$(for a in ~/Pictures/wallpapers/*.png; do echo -en "$a\0icon\x1f$a\n"; done | rofi -dmenu -config ~/.config/rofi/waller/config.rasi -theme ~/.config/rofi/waller/style.rasi)
  if [[ -n "$wall" && -f "$wall" ]]; then
    swww img "$wall" --outputs eDP-1 --transition-type none --transition-duration 0
    wal -i "$wall"
  else
    echo "No wallpaper selected or invalid file."
  fi
}

Auto_Change() {
  while true; do
    Random_wallpaper
    sleep 1800
  done
}

Random_wallpaper() {
  local random_wall
  random_wall=$(find ~/Pictures/wallpapers -type f \( -iname "*.png" -o -iname "*.jpg" \) | shuf -n 1)
  if [[ -f "$random_wall" ]]; then
    swww img "$random_wall" --outputs eDP-1 --transition-type none --transition-duration 0
  else
    echo "No valid wallpaper found."
  fi
}

Random_wallpaper_wal() {
  local random_wall
  random_wall=$(find ~/Pictures/wallpapers -type f \( -iname "*.png" -o -iname "*.jpg" \) | shuf -n 1)
  if [[ -f "$random_wall" ]]; then
    swww img "$random_wall" --outputs eDP-1 --transition-type none --transition-duration 0
    wal -i "$random_wall"
  else
    echo "No valid wallpaper found."
  fi
}
Restore_wallpaper() {
  local current_wall
  current_wall=$(swww query | jq -r '.current_img')
  if [[ -f "$current_wall" ]]; then
    swww img "$current_wall" --outputs eDP-1 --transition-type none --transition-duration 0
  else
    echo "No wallpaper to restore."
  fi
}

Mini() {
  mini_wall=~/Pictures/wallpapers/roseCenterPink.png
  swww img "$mini_wall" --outputs HDMI-A-3 --transition-type none --transition-duration 0
}

case "$1" in
--select)
  Select_wallpaper
  ;;
--select-wal)
  Select_wallpaper_wal
  ;;
--auto)
  Auto_Change
  ;;
--random)
  Random_wallpaper
  ;;
--random-wal)
  Random_wallpaper_wal
  ;;
--restore)
  Restore_wallpaper
  ;;
--mini)
  Mini
  ;;
*)
  echo "Usage: $0 --select | --select-wal | --random | --random-wal | --auto | --restore | --mini"
  exit 1
  ;;
esac
