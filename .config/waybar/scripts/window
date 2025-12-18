#!/bin/bash

# Get the title of the active window using JSON output for reliability
title=$(hyprctl -j activewindow | jq -r '.title')

# Check if a title was found and is not null
if [ -n "$title" ] && [ "$title" != "null" ]; then
  # Print the title with actual newlines (vertical text)
  echo "$title" | sed 's/./&\n/g'
else
  # Fallback if no active window is found
  echo ""
fi
