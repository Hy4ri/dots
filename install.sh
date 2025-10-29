#!/usr/bin/env bash

clear

cat <<"EOF"

███╗   ███╗███████╗███████╗    ██████╗  ██████╗ ████████╗ ███████╗██╗██╗     ███████╗███████╗
████╗ ████║██╔════╝╚════██║    ██╔══██╗██╔═══██╗╚══██╔══╝ ██╔════╝██║██║     ██╔════╝██╔════╝
██╔████╔██║███████╗    ██╔╝    ██║  ██║██║   ██║   ██║    █████╗  ██║██║     █████╗  ███████╗
██║╚██╔╝██║╚════██║   ██╔╝     ██║  ██║██║   ██║   ██║    ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██║ ╚═╝ ██║███████║   ██║      ██████╔╝╚██████╔╝   ██║    ██║     ██║███████╗███████╗███████║
╚═╝     ╚═╝╚══════╝   ╚═╝      ╚═════╝  ╚═════╝    ╚═╝    ╚═╝     ╚═╝╚══════╝╚══════╝╚══════
EOF

cd ~/dots

# Backup
echo -n "Backup /home? y/n:  "
read Backup

case "$Backup" in
yes | Yes | y | Y)
  mkdir -p ~/old-config
  [ -d ~/.config ] && mv ~/.config/ ~/old-config/
  [ -d ~/.local/share/icons ] && mv ~/icons/ ~/old-config/
  [ -d ~/.local/share/themes ] && mv ~/themes/ ~/old-config/
  [ -d ~/.themes ] && mv ~/.themes/ ~/old-config/
  [ -f ~/.zshrc ] && mv ~/.zshrc ~/old-config/
  ;;
No | no | n | N) ;;
*) ;;
esac

### Nix

echo -n "Bulid Nix? y/n:  "
read Nix

case "$Nix" in
yes | Yes | y | Y)
  echo "Building Nix"
  ~/dots/scripts/./nix.sh
  ;;
No | no | n | N) ;;
*) ;;
esac

### Dotfiles

echo -n "Apply Dotfiles? y/n:  "
read Dotfiles

case "$Dotfiles" in
yes | Yes | y | Y)
  [ ! -d ~/Documents ] && mkdir ~/Documents/Projects/dots/ && cp ~/dots -r ~/Documents/Projects/dots/
  ~/dots/scripts/./symlink.sh
  cd ~/dots
  cp -r .local/share/icons ~/.local/share/icons
  cp -r.local/share/themes ~/.local/share/themes
  cp -r.local/share/themes ~/.themes
  cd ~/.local/share/icons
  tar -xvzf Bibata-Modern-Ice.tar.gz
  tar -xvzf Papirus-Dark.tar.gz
  cd ~/.themes
  tar -xvzf theme.tar.gz
  cd ~/.local/share/themes
  tar -xvzf theme.tar.gz
  mkdir -p ~/Pictures/
  cd ~/Pictures/
  git clone https://github.com/hy4ri/wallpapers
  ;;
No | no | n | N) ;;
*) ;;
esac

sleep 1

rm -rf ~/dots

cat <<"EOF"
██████╗  ██████╗ ███╗   ██╗███████╗
██╔══██╗██╔═══██╗████╗  ██║██╔════╝
██║  ██║██║   ██║██╔██╗ ██║█████╗
██║  ██║██║   ██║██║╚██╗██║██╔══╝E
██████╔╝╚██████╔╝██║ ╚████║███████╗
╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝
EOF

echo "Rebooting in 10s"
sleep 10 && systemctl reboot
