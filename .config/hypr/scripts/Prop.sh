#!/usr/bin/env bash

prop=$(hyprprop | jq -r '"class=\(.class)\ntitle=\(.title)\nxwayland=\(.xwayland)"')

wl-copy $prop

notify-send -t 300 "$prop"
