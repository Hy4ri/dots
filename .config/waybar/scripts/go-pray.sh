#!/usr/bin/env bash
set -euo pipefail

# WARN: make sure go-pray is in your PATH
_text="$(go-pray next)"
_calendar="$(go-pray calendar)"
_class="$(cut -d' ' -f1 <<<"${_text}")"

jq \
  --null-input \
  --unbuffered \
  --compact-output \
  --arg class "${_class}" \
  --arg text "${_text}" \
  --arg calendar "${_calendar}" \
  '{ "text": "\($text)", "tooltip": "\($calendar)", "class": "\($class)" }'
