#!/bin/bash

$helper -R --noconfirm pulseaudio pulseaudio-alsa pulseaudio-bluetooth

systemctl --user disable --now pulseaudio.socket pulseaudio.service

$helper -Sy --noconfirm --needed pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse

systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service
systemctl --user enable --now pipewire.service


sleep 1
cd ~/m57-dots-install
