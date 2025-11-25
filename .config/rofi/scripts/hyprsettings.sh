#!/usr/bin/env bash

MENU_ITEMS=(
  "Blur|blur"
  "Opacity 1.0|opacity_10"
  "Opacity 0.9|opacity_9"
  "Opacity 0.8|opacity_8"
  "Opacity 0.2|opacity_2"
  "Opacity 0.0|opacity_0"
  "Decoration|decoration"
)

blur() {
hyprctl dispatch setprop active no_blur toggle
}

opacity_10() {
hyprctl dispatch setprop active opacity 1
}
opacity_9() {
hyprctl dispatch setprop active opacity 0.9
}
opacity_8() {
hyprctl dispatch setprop active opacity 0.8
}
opacity_2() {
hyprctl dispatch setprop active opacity 0.2
}
opacity_0() {
hyprctl dispatch setprop active opacity 0.0
}

decoration() {
hyprctl dispatch setprop active decorate toggle
}

CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "Rules" -i)

for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
