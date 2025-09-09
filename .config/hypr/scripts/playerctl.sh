#!/usr/bin/env bash

# Set volume step
STEP=0.10
iDIR="$HOME/.config/dunst/icons"
current_volume=$(playerctl volume)

# Check argument
case "$1" in
--inc)
  new_volume=$(echo "$current_volume + 0.1" | bc)
  ;;
--dec)
  new_volume=$(echo "$current_volume - 0.1" | bc)
  ;;
*)
  echo "Usage: $0 [+|-]"
  exit 1
  ;;
esac

# Clamp volume between 0 and 100
if (($(echo "$new_volume > 1.0" | bc -l))); then
  new_volume=1.0
elif (($(echo "$new_volume < 0.0" | bc -l))); then
  new_volume=0.0
fi
# Set new volume
playerctl volume $new_volume

percent_volume=$(echo "$new_volume*100" | bc | cut -d'.' -f1)

get_icon() {
  if [[ "$percent_volume" -le 30 ]]; then
    echo "$iDIR/volume-low.png"
  elif [[ "$percent_volume" -le 60 ]]; then
    echo "$iDIR/volume-mid.png"
  else
    echo "$iDIR/volume-high.png"
  fi
}

notify-send -e -h int:value:"${percent_volume}" -h string:x-canonical-private-synchronous:volume_notif -u low -i "$(get_icon)" "Volume: ${percent_volume}%"
