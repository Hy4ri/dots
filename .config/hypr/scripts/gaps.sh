#!/usr/bin/env bash

gaps_in=$(hyprctl -j getoption general:gaps_in | jq '.custom' | awk '{print $1}' | cut -c 2-)
gaps_out=$(hyprctl -j getoption general:gaps_out | jq '.custom' | awk '{print $1}' | cut -c 2-)

function inc_gaps() {
  hyprctl keyword general:gaps_in $((gaps_in + 1))
  hyprctl keyword general:gaps_out $((gaps_out + 1))
}

function dec_gaps() {
  hyprctl keyword general:gaps_in $((gaps_in - 1))
  hyprctl keyword general:gaps_out $((gaps_out - 1))
}

while [[ $# -gt 0 ]]; do
  case $1 in
  --inc_gaps)
    inc_gaps
    shift
    ;;
  --dec_gaps)
    dec_gaps
    shift
    ;;
  *)
    printf "Error: Unknown option %s" "$1"
    exit 1
    ;;
  esac
done
