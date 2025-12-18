#!/usr/bin/env bash

hypr() {
  pkill -SIGUSR1 .waybar-wrapped
}

niri() {
  if pgrep -x ".waybar-wrapped" >/dev/null; then
    pkill -SIGUSR1 .waybar-wrapped
  else
    waybar -c ~/.config/waybar/configs/Niri.jsonc -s ~/.config/waybar/style/Main.css &
  fi
}

mango() {
  if pgrep -x ".waybar-wrapped" >/dev/null; then
    pkill -SIGUSR1 .waybar-wrapped
  else
    waybar -c ~/.config/waybar/configs/Mango.jsonc -s ~/.config/waybar/style/Main.css &
  fi
}

case "$1" in
--hypr)
  hypr
  ;;
--niri)
  niri
  ;;
--mango)
  mango
  ;;
*)
  hypr
  ;;
esac
