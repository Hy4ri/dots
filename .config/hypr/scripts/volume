#!/usr/bin/env bash

iDIR="$HOME/.config/dunst/icons"

get_volume() {
  local vol
  vol=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2*100)}')
  local mute
  mute=$(wpctl get-volume @DEFAULT_SINK@ | grep -o 'MUTED')

  if [[ "$mute" == "MUTED" ]]; then
    echo "Muted"
  else
    echo "${vol}%"
  fi
}

get_icon() {
  local current
  current=$(get_volume)
  if [[ "$current" == "Muted" ]]; then
    echo "$iDIR/volume-mute.png"
  elif [[ "${current%\%}" -le 30 ]]; then
    echo "$iDIR/volume-low.png"
  elif [[ "${current%\%}" -le 60 ]]; then
    echo "$iDIR/volume-mid.png"
  else
    echo "$iDIR/volume-high.png"
  fi
}

notify_user() {
  local current
  current=$(get_volume)
  if [[ "$current" == "Muted" ]]; then
    notify-send -e -h string:x-canonical-private-synchronous:volume_notif -u low -i "$(get_icon)" "Volume: Muted"
  else
    local value="${current%\%}"
    notify-send -e -h int:value:"$value" -h string:x-canonical-private-synchronous:volume_notif -u low -i "$(get_icon)" "Volume: $current"
  fi
}

inc_volume() {
  wpctl set-mute @DEFAULT_SINK@ 0
  wpctl set-volume -l 1.5 @DEFAULT_SINK@ 0.02+ && notify_user
}

dec_volume() {
  wpctl set-mute @DEFAULT_SINK@ 0
  wpctl set-volume @DEFAULT_SINK@ 0.02- && notify_user
}

toggle_mute() {
  wpctl set-mute @DEFAULT_SINK@ toggle
  local mute
  mute=$(wpctl get-volume @DEFAULT_SINK@ | grep -o 'MUTED')
  if [[ "$mute" == "MUTED" ]]; then
    notify-send -e -u low -i "$iDIR/volume-mute.png" "Volume Switched OFF"
  else
    notify-send -e -u low -i "$(get_icon)" "Volume Switched ON"
  fi
}

get_mic_volume() {
  local vol mute
  vol=$(wpctl get-volume @DEFAULT_SOURCE@ | awk '{print int($2*100)}')
  mute=$(wpctl get-volume @DEFAULT_SOURCE@ | grep -o 'MUTED')
  if [[ "$mute" == "MUTED" ]]; then
    echo "Muted"
  else
    echo "${vol}%"
  fi
}

get_mic_icon() {
  local current
  current=$(get_mic_volume)
  if [[ "$current" == "Muted" ]]; then
    echo "$iDIR/microphone-mute.png"
  else
    echo "$iDIR/microphone.png"
  fi
}

notify_mic_user() {
  local volume icon
  volume=$(get_mic_volume)
  icon=$(get_mic_icon)
  local val="${volume%\%}"
  notify-send -e -h int:value:"$val" -h string:x-canonical-private-synchronous:mic_notif -u low -i "$icon" "Mic-Level: $volume"
}

toggle_mic() {
  wpctl set-mute @DEFAULT_SOURCE@ toggle
  local mute
  mute=$(wpctl get-volume @DEFAULT_SOURCE@ | grep -o 'MUTED')
  if [[ "$mute" == "MUTED" ]]; then
    notify-send -e -u low -i "$iDIR/microphone-mute.png" "Microphone Switched OFF"
  else
    notify-send -e -u low -i "$iDIR/microphone.png" "Microphone Switched ON"
  fi
}

inc_mic_volume() {
  wpctl set-mute @DEFAULT_SOURCE@ 0
  wpctl set-volume @DEFAULT_SOURCE@ 0.05+ && notify_mic_user
}

dec_mic_volume() {
  wpctl set-mute @DEFAULT_SOURCE@ 0
  wpctl set-volume @DEFAULT_SOURCE@ 0.05- && notify_mic_user
}

case "$1" in
--get) get_volume ;;
--inc) inc_volume ;;
--dec) dec_volume ;;
--toggle) toggle_mute ;;
--toggle-mic) toggle_mic ;;
--get-icon) get_icon ;;
--get-mic-icon) get_mic_icon ;;
--mic-inc) inc_mic_volume ;;
--mic-dec) dec_mic_volume ;;
*) get_volume ;;
esac
