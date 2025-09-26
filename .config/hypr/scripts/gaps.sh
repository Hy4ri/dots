#!/usr/bin/env bash

gaps_in=$(hyprctl -j getoption general:gaps_in | jq '.custom' | awk '{print $1}' | cut -c 2-)
gaps_out=$(hyprctl -j getoption general:gaps_out | jq '.custom' | awk '{print $1}' | cut -c 2-)

inc_gaps() {
  hyprctl keyword general:gaps_in $((gaps_in + 1))
  hyprctl keyword general:gaps_out $((gaps_out + 1))
}

dec_gaps() {
  hyprctl keyword general:gaps_in $((gaps_in - 1))
  hyprctl keyword general:gaps_out $((gaps_out - 1))
}

reset() {
  hyprctl keyword general:gaps_in 0
  hyprctl keyword general:gaps_out 0
}

while [[ $# -gt 0 ]]; do
  case $1 in
  --inc_gaps)
    inc_gaps
    S
    ;;
  --dec_gaps)
    dec_gaps
    ;;
  --reset)
    reset
    ;;
  *)
    printf "Error: Unknown option %s" "$1"
    exit 1
    ;;
  esac
done
