#!/usr/bin/env bash


update() {
  pkill spotify
  curl -fssl https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
  ~/.spicetify/spicetify update
  ~/.spicetify/spicetify backup apply
  ~/.spicetify/spicetify restore backup apply
}

install() {
  pkill spotify
  curl -fssl https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
}
case "$1" in
  --install)
    install
    ;;
  --update)
    update
    ;;
  *) 
    update
    ;;
esac

