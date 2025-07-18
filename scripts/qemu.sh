#!/usr/bin/env bash

# QEMU

$helper --needed --noconfirm -S \
  qemu-base \
  qemu-emulators-full \
  qemu-guest-agent \
  qemu-user-static \
  qemu-block-gluster \
  qemu-block-iscsi \
  samba

# libvert

$helper --needed --noconfirm -S \
  libvirt \
  dnsmasq \
  openbsd-netcat \
  virt-manager \
  vde2 \
  bridge-utils \
  libgeustfs

sudo systemctl start libvirtd.service
sudo systemctl enable libvirtd.service

sudo systemctl start libvirtd.socket
sudo systemctl enable libvirtd.socket

sudo usermod -aG libvirt $USER

# Inform the user to log out and log back in to apply group changes
echo "Installation complete. Please log out and log back in to apply group changes."
