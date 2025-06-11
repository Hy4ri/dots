#!/usr/bin/env bash

$helper -R --noconfirm \
  pulseaudio \
  pulseaudio-alsa \
  pulseaudio-bluetooth

systemctl --user disable --now pulseaudio.socket pulseaudio.service

$helper -Sy --needed \
  pipewire \
  pipewire-audio \
  pipewire-alsa \
  pipewire-pulse \
  pipewire-jack \
  wireplumber

systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service
systemctl --user enable --now pipewire.service

cd ~/dots
