#!/usr/bin/env bash

prop=$(hyprprop | jq -r '"class=\(.class)\ntitle=\(.title)\nxwayland=\(.xwayland)"')

notify-send -t 300 "$prop"
