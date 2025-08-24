#!/usr/bin/env bash

OUT() {
  hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | grep float | awk '{print $2 - 1}')" #cursor zoom out
}

IN() {
  hyprctl keyword cursor:zoom_factor "$(hyprctl getoption cursor:zoom_factor | grep float | awk '{print $2 + 1}')" #cursor zoom in
}

if [[ "$1" == "--in" ]]; then
  IN
elif [[ "$1" == "--out" ]]; then
  OUT
else
  echo -e "Available Options : --in --out"
fi
