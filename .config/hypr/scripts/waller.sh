#!/usr/bin/env bash

MONITORS=eDP-1,HDMI-A-3
Duration=600

Select_wallpaper() {
  wall=$(for a in ~/Pictures/wallpapers/*.png; do echo -en "$a\0icon\x1f$a\n"; done | rofi -dmenu -config ~/.config/rofi/waller/config.rasi -theme ~/.config/rofi/waller/style.rasi)
  if [[ -n "$wall" && -f "$wall" ]]; then
    swww img "$wall" --outputs $MONITORS --transition-type none --transition-duration 0
  else
    echo "No wallpaper selected or invalid file."
  fi
}

Random_wallpaper() {
  random=$(find ~/Pictures/wallpapers -type f \( -iname "*.png" -o -iname "*.jpg" \) | shuf -n 1)
  if [[ -f "$random" ]]; then
    swww img "$random" --outputs $MONITORS --transition-type none --transition-duration 0
  else
    echo "No valid wallpaper found."
  fi
}

Auto_Change() {
  while true; do
    Random_wallpaper
    sleep "$Duration"
  done
}

Restore_wallpaper() {
  local current_wall
  current_wall=$(swww query | jq -r '.current_img')
  if [[ -f "$current_wall" ]]; then
    swww img "$current_wall" --outputs $MONITORS --transition-type none --transition-duration 0
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
--auto)
  Auto_Change
  ;;
--random)
  Random_wallpaper
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
