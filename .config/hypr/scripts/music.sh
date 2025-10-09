#!/usr/bin/env bash

pkill spotify
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
~/.spicetify/spicetify update
~/.spicetify/spicetify backup apply
~/.spicetify/spicetify restore backup apply
