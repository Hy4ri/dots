#!/usr/bin/env bash

profile=$(powerprofilesctl get)

get_profile() {
  case "$profile" in
    "performance") echo "󱐋";;
    "balanced") echo "";;
    "power-saver") echo "";;
    *) echo "❓";;
  esac
}

performance() {
  powerprofilesctl set performance
  hyprctl reload
  notify-send "Performance mode"
}

balanced() {
  powerprofilesctl set balanced
  hyprctl reload
  notify-send "Balanced mode"
}

powerSaver() {
  hyprctl --batch "\
    keyword monitor eDP-1,1920x1080@60,0x0,1:\
    keyword animations:enabled 0;\
    keyword decoration:shadow:enabled 0;\
    keyword decoration:blur:enabled 0;\
    keyword general:border_size 0;\
    keyword animation borderangle,0; \
    keyword decoration:rounding 0; \
    keyword decoration:fullscreen_opacity 1; \
    keyword general:gaps_in 0; \
    keyword general:gaps_out 0" 
  sleep 1
  powerprofilesctl set power-saver
  sleep 1
  notify-send "Powersaving mode"
}

if [[ "$1" == "--performance" ]]; then
  performance
elif [[ "$1" == "--balanced" ]]; then
  balanced
elif [[ "$1" == "--powersaver" ]]; then
  powerSaver
else
  echo "{\"text\": \"$(get_profile)\", \"tooltip\": \"$(powerprofilesctl get) mode | Click to change\", \"class\": \"power-mode\"}"
fi
