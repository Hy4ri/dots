#!/usr/bin/env bash
set -euo pipefail

# Vars
config="$HOME/.config"
dots="$HOME/dots"

if [ -d "$HOME/Documents/Projects/dots" ]; then
  dots="$HOME/Documents/Projects/dots"
fi

echo "Linking configs from: $dots"

safe_link() {
  local src=$1
  local dest=$2

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Removing existing: $dest"
    rm -rf "$dest"
  fi

  ln -s "$src" "$dest"
  echo "Linked: $dest → $src"
}

safe_link "$dots/.zshrc" "$HOME/.zshrc"
safe_link "$dots/.zprofile" "$HOME/.zprofile"
safe_link "$dots/.tmux.conf" "$HOME/.tmux.conf"

for dir in hypr foot rofi waybar dunst yazi niri nvim; do
  safe_link "$dots/.config/$dir" "$config/$dir"
done

echo "Done :)"
