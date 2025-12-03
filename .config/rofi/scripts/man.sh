#!/usr/bin/env bash
set -euo pipefail

selected=$(apropos -l . 2>/dev/null | awk '{print $1, $2}' | rofi -dmenu -p "Man Pages" -i)
[[ -z "$selected" ]] && exit 0

page=$(echo "$selected" | awk '{print $1}')
section=$(echo "$selected" | grep -oP '\(\K[^)]+' || echo "")

if [[ -n "$section" ]]; then
    man -Tpdf "$section" "$page" | zathura - &
else
    man -Tpdf "$page" | zathura - &
fi


