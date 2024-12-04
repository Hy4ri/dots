#!/bin/bash

$helper -Sy --needed gstreamer gst-libav gst-plugins-bad gst-plugins-base \
gst-plugins-ugly gst-plugins-good libdvdcss alsa-utils alsa-firmware pavucontrol \
lib32-pipewire-jack pipewire-support ffmpeg ffmpegthumbs ffnvcodec-headers bluez \
bluez-utils bluez-plugins bluez-hid2hci bluez-cups bluez-libs bluez-tools \
bluez-deprecated-tools

printf " Activating Bluetooth Services...\n"
systemctl enable --now bluetooth.service

sleep 3
cd ~/m57-dots-install
