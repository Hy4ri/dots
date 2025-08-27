#!/usr/bin/env bash

man -k . | rofi -dmenu -p "Title" -i | awk '{print $1}' | xargs -r man -Tpdf | zathura -
