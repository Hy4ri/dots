#!/usr/bin/env bash

# Style
dir="$HOME/.config/rofi/launchers/"
theme='style'
notes_dir=~/Documents/notes

# Define menu items as "Label|Function Name"
MENU_ITEMS=(
  "New note|new"
  "Note List|list"
)

# Define functions for each menu item

new() {
  name=$(rofi -dmenu -p "Note name:" -theme "${dir}/${theme}.rasi")
  timestamp=$(date +%d-%m-%Y)

  [[ -z "$name" ]] && name="$timestamp"
  safe_name=$(echo "$name" | sed 's/[^a-zA-Z0-9._ -]/_/g' | tr ' ' '_')

  mkdir -p "$notes_dir"
  path="${notes_dir}/${safe_name}.md"

  touch "$path"
  foot -e nvim "$path"
}

list() {
  selected=$(ls -t ~/Documents/notes/ | rofi -dmenu -theme "${dir}/${theme}.rasi")
  [[ -n "$selected" ]] && foot -e nvim $notes_dir/$selected
}

# Create Rofi menu
CHOICE=$(for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label _ <<<"$item"
  echo "$label"
done | rofi -dmenu -p "Notes" -theme ${dir}/${theme}.rasi)

# Match selection and call corresponding function
for item in "${MENU_ITEMS[@]}"; do
  IFS="|" read -r label func <<<"$item"
  if [[ "$CHOICE" == "$label" ]]; then
    "$func"
    exit 0
  fi
done

exit 1
