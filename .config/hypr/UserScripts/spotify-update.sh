#!/bin/bash

pkill spotify
spicetify update
curl -fsSL https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.sh | sh
spicetify backup apply
spicetify restore backup apply
spotify-launcher 