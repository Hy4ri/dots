#!/usr/bin/env bash

iDIR="$HOME/.config/dunst/icons"
step=5

# Get brightness for a specific device
get_device_brightness() {
  local device=$1
  if [[ -z "$device" ]]; then
    echo "0"
    return
  fi
  IFS=, read -r _ _ _ percent _ <<< "$(brightnessctl -m -d "$device")"
  echo "${percent%\%}"
}

# Get brightness for the default backlight device
get_backlight() {
  IFS=, read -r _ _ _ percent _ <<< "$(brightnessctl -c backlight -m)"
  echo "${percent%\%}"
}

# Get icons
get_icon() {
  local current=$1
  if   (( current <= 20 )); then echo "$iDIR/brightness-20.png"
  elif (( current <= 40 )); then echo "$iDIR/brightness-40.png"
  elif (( current <= 60 )); then echo "$iDIR/brightness-60.png"
  elif (( current <= 80 )); then echo "$iDIR/brightness-80.png"
  else echo "$iDIR/brightness-100.png"
  fi
}

# Notify
notify_user() {
  local current=$1
  local icon=$2
  local type=$3
  local title="Brightness"
  
  if [[ "$type" == "Keyboard" ]]; then
    title="Keyboard Brightness"
  fi

  notify-send -e -h string:x-canonical-private-synchronous:brightness_notif \
    -h "int:value:$current" -u low -i "$icon" "$title : ${current}%"
}

# Change brightness for main monitor only
change_backlight() {
  local amount="$1"
  
  # brightnessctl handles clamping and math natively for the default device
  brightnessctl set "$amount" > /dev/null

  # Get current brightness of the default device for notification
  local current
  current=$(get_backlight)
  local icon
  icon=$(get_icon "$current")
  notify_user "$current" "$icon"
}

# Change brightness for keyboard
change_kbd_backlight() {
  local amount="$1"
  local kbd_device
  kbd_device=$(brightnessctl -l -m | grep "kbd_backlight" | head -n1 | cut -d, -f1)

  if [[ -z "$kbd_device" ]]; then
    return
  fi

  brightnessctl -d "$kbd_device" set "$amount" > /dev/null
  
  local current
  current=$(get_device_brightness "$kbd_device")
  local icon
  icon=$(get_icon "$current")
  notify_user "$current" "$icon" "Keyboard"
}

# Execute accordingly
case "$1" in
  "--get")
    get_backlight
    ;;
  "--inc")
    change_backlight "${step}%+"
    ;;
  "--dec")
    change_backlight "${step}%-"
    ;;
  "--kbd-inc")
    change_kbd_backlight "${step}%+"
    ;;
  "--kbd-dec")
    change_kbd_backlight "${step}%-"
    ;;
  "--kbd-get")
    kbd_device=$(brightnessctl -l -m | grep "kbd_backlight" | head -n1 | cut -d, -f1)
    get_device_brightness "$kbd_device"
    ;;
  *)
    get_backlight
    ;;
esac