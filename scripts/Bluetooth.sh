#!/usr/bin/env bash

$helper -Sy --needed \
    bluez bluez-utils bluez-tools bluez-deprecated-tools bluez-obex \
    blueman

printf " Activating Bluetooth Services...\n"
systemctl enable --now bluetooth.service

cd ~/dots
