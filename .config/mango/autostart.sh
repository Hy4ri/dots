#!/usr/bin/env bash

set +e

dbus-update-activation-environment --systemd >/dev/null 2>&1 &
systemctl --user import-environment >/dev/null 2>&1 &
hash dbus-update-activation-environment 2>/dev/null >/dev/null 2>&1 &

systemctl --user start hyprpolkitagent >/dev/null 2>&1 &

hypridle >/dev/null 2>&1 &
swww-daemon --format argb >/dev/null 2>&1 &
# wl-paste -t text -w cliphist store -max-items 1000000 >/dev/null 2>&1 &
# wl-paste -t image -w cliphist store -max-items 1000000 >/dev/null 2>&1 &
foot --server >/dev/null 2>&1 &
$HOME/.config/hypr/scripts/waller.sh --auto >/dev/null 2>&1 &
$HOME/.config/hypr/scripts/theker.sh >/dev/null 2>&1 &
$HOME/.config/hypr/scripts/waller.sh --mini >/dev/null 2>&1 &
wlsunset -l 32.0346 -L 35.7269 >/dev/null 2>&1 &
vicinae server >/dev/null 2>&1 &
