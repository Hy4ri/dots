#!/usr/bin/env bash

cd ~/dots/Nix

sudo nix-rebuild switch --flake .#hyari
