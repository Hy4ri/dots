#!/usr/bin/env bash
set -euo pipefail

man -w | rofi -dmenu -p "Title" -i | awk '{print $1}' | xargs -r man -Tpdf | zathura -
