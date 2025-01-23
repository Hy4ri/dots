#!/bin/bash
 
$helper --needed --noconfirm -S qemu libvirt virt-manager virt-viewer bridge-utils dnsmasq ovmf edk2-ovmf

sudo systemctl start libvirtd
sudo systemctl enable libvirtd

sudo usermod -aG libvirt $USER

# Inform the user to log out and log back in to apply group changes
echo "Installation complete. Please log out and log back in to apply group changes."

sleep 1
cd ~/m57-dots-install
