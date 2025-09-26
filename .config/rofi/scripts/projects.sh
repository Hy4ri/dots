#!/usr/bin/env bash

project_dir=~/Documents/Projects/

list() {
  selected=$(ls -t ~/Documents/Projects/ | rofi -dmenu -i -p "Project")
  [[ -n "$selected" ]] && foot nvim $project_dir/$selected
}

list
