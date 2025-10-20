#!/usr/bin/env bash

if pgrep -x ".waybar-wrapped" >/dev/null; then
  pkill -x .waybar-wrapped
else
  waybar &
fi
