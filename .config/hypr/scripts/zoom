#!/usr/bin/env bash

IN() {
  hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')
}

OUT() {
  hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')
}

if [[ "$1" == "--in" ]]; then
  IN
elif [[ "$1" == "--out" ]]; then
  OUT
else
  echo -e "Available Options : --in --out"
fi
