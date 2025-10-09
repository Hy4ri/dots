#!/usr/bin/env bash

MENU_ITEMS=(
  "C to F|cf"
  "C to K|ck"
  "K to C|kc"
  "K to F|kf"
  "F to C|fc"
  "F to K|fk"
)

cf() {
  temp=$(rofi -dmenu -p "Temperature (°C):")
  result=$(echo "scale=2; (9/5) * $temp + 32" | bc -l)
  notify-send "Temperature" "$result °F"
}

ck() {
  temp=$(rofi -dmenu -p "Temperature (°C):")
  result=$(echo "scale=2; $temp + 273.15" | bc -l)
  notify-send "Temperature" "$result K"
}

kc() {
  temp=$(rofi -dmenu -p "Temperature (K):")
  result=$(echo "scale=2; $temp - 273.15" | bc -l)
  notify-send "Temperature" "$result °C"
}

kf() {
  temp=$(rofi -dmenu -p "Temperature (K):")
  result=$(echo "scale=2; (9/5)*($temp - 273.15) + 32" | bc -l)
  notify-send "Temperature" "$result °F"
}

fc() {
  temp=$(rofi -dmenu -p "Temperature (°F):")
  result=$(echo "scale=2; (5/9) * ($temp - 32)" | bc -l)
  notify-send "Temperature" "$result °C"
}

fk() {
  temp=$(rofi -dmenu -p "Temperature (°F):")
  result=$(echo "scale=2; (5/9) * ($temp - 32) + 273.15" | bc -l)
  notify-send "Temperature" "$result K"
}

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "Temperature Converter" -i)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
