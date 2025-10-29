#!/usr/bin/env bash

PLUGINS_DIR="$HOME/.zsh/plugins"
echo "Plugin directory will be: $PLUGINS_DIR"
mkdir -p "$PLUGINS_DIR"

plugins=(
    "Aloxaf/fzf-tab"
    "zsh-users/zsh-syntax-highlighting"
    "zsh-users/zsh-autosuggestions"
)

echo "Cloning plugins..."

for plugin in "${plugins[@]}"; do
    repo_name=$(basename "$plugin")
    target_dir="$PLUGINS_DIR/$repo_name"
    repo_url="https://github.com/$plugin.git"

    if [ ! -d "$target_dir" ]; then
        echo "Cloning $plugin..."
        git clone "$repo_url" "$target_dir"
    else
        echo "$repo_name is already cloned. Skipping."
    fi
done

echo "All plugins are cloned."
