#!/usr/bin/env bash

wall=$(for a in ~/Pictures/wallpapers/*.png; do echo -en "$a\0icon\x1f$a\n"; done | rofi -dmenu -config ~/.config/rofi/waller/config.rasi -theme ~/.config/rofi/waller/style.rasi)
if [[ -n "$wall" && -f "$wall" ]]; then
  hyprctl hyprpaper preload "$wall"
  hyprctl hyprpaper wallpaper "eDP-1,$wall"
else
  echo "No wallpaper selected or invalid file."
fi
