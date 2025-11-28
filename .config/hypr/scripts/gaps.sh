#!/usr/bin/env bash

get_gaps_in() {
  hyprctl -j getoption general:gaps_in \
    | jq -r '.custom' \
    | awk '{print $1}'
}

get_gaps_out() {
  hyprctl -j getoption general:gaps_out \
    | jq -r '.custom' \
    | awk '{print $1}'
}

in=$(get_gaps_in)
out=$(get_gaps_out)

inc_gaps() {
  hyprctl keyword general:gaps_in $((in + 1))
  hyprctl keyword general:gaps_out $((out + 1))
}

dec_gaps() {
  hyprctl keyword general:gaps_in $((in - 1))
  hyprctl keyword general:gaps_out $((out - 1))
}

reset() {
  hyprctl keyword general:gaps_in 0
  hyprctl keyword general:gaps_out 0
}

while [[ $# -gt 0 ]]; do
  case $1 in
    --inc_gaps)
      inc_gaps
      ;;
    --dec_gaps)
      dec_gaps
      ;;
    --reset)
      reset
      ;;
    *)
      printf "Error: Unknown option %s\n" "$1"
      exit 1
      ;;
  esac
  shift
done
