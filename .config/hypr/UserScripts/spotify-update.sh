#!/bin/bash

pkill spotify
spicetify update
curl -fsSL https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.sh | sh
spicetify restore backup apply