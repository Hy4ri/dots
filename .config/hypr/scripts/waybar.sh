#!/usr/bin/env bash

hypr() {
  if pgrep -x ".waybar-wrapped" >/dev/null; then
    pkill -x .waybar-wrapped
  else
    waybar &
  fi
}

niri() {
  if pgrep -x ".waybar-wrapped" >/dev/null; then
    pkill -x .waybar-wrapped
  else
    waybar -c ~/.config/waybar/configs/Niri.jsonc -s ~/.config/waybar/style/Main.css &
  fi
}

case "$1" in
--hypr)
  hypr
  ;;
--niri)
  niri
  ;;
*)
  hypr
  ;;
esac
