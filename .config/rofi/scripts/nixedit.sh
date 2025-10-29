#!/usr/bin/env bash

Configs="$HOME/Documents/Projects/dots/nix/"
term="foot"

menu() {
  printf "1. Nix Config\n"
  printf "2. Nix Packages\n"
  printf "3. Nix Services\n"
  printf "4. Nix Networking\n"
  printf "5. Nix Flake\n"
  printf "6. Nix Hardware\n"
  printf "7. Nix Folder\n"
}

main() {
  choice=$(menu | rofi -i -dmenu | cut -d. -f1)
  case $choice in
  1)
    $term nvim "$Configs/configuration.nix"
    ;;
  2)
    $term nvim "$Configs/pkgs.nix"
    ;;
  3)
    $term nvim "$Configs/services.nix"
    ;;
  4)
    $term nvim "$Configs/networking.nix"
    ;;
  5)
    $term nvim "$Configs/flake.nix"
    ;;
  6)
    $term nvim "$Configs/hardware-configuration.nix"
    ;;
  7)
    $term nvim $Configs
    ;;
  *) ;;
  esac
}

main
