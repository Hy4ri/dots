#!/usr/bin/env bash
set -euo pipefail

# Define menu items as "Label|Function Name"
MENU_ITEMS=(
  "Ai search|ai"
  "Web search|web"
  "Image search|image"
  "Video search|video"
  "Maps search|map"
)

# Define functions for each menu item
web() {
  search=$(rofi -dmenu -i -p "Google Web:")
  if [ -n "$search" ]; then
    encoded=$(printf '%s' "$search" | jq -sRr @uri)
    xdg-open "https://www.google.com/search?q=$encoded&udm=14&tbs=li:1"
  fi
}

image() {
  search=$(rofi -dmenu -i -p "Google images:")
  if [ -n "$search" ]; then
    encoded=$(printf '%s' "$search" | jq -sRr @uri)
    xdg-open "https://www.google.com/search?q=$encoded&udm=2&tbs=li:1"
  fi
}

map() {
  search=$(rofi -dmenu -i -p "Google Maps:")
  if [ -n "$search" ]; then
    encoded=$(printf '%s' "$search" | jq -sRr @uri)
    xdg-open "https://www.google.com/maps/search/$encoded"
  fi
}

video() {
  search=$(rofi -dmenu -i -p "Google videos:")
  if [ -n "$search" ]; then
    encoded=$(printf '%s' "$search" | jq -sRr @uri)
    xdg-open "https://www.google.com/search?q=$encoded&udm=7&tbs=li:1"
  fi
}

ai() {
  search=$(rofi -dmenu -i -p "Ai search:")
  if [ -n "$search" ]; then
    encoded=$(printf '%s' "$search" | jq -sRr @uri)
    xdg-open "https://www.perplexity.ai/?q=$encoded"
  fi
}

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "Search" -i)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
