#!/usr/bin/env bash

man -w | rofi -dmenu -p "Title" -i | awk '{print $1}' | xargs -r man -Tpdf | zathura -
