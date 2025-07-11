#!/usr/bin/env bash

mount --mkdir -t virtiofs shared ~/shared

DISK=/dev/vda

sgdisk --zap-all "$DISK"
sgdisk --clear "$DISK"
sgdisk --new=1:0:+512MB --typecode=1:ef00 --change-name=1:"EFI System Partition" "$DISK"
sgdisk --new=2:0:0 --typecode=2:8300 --change-name=2:"Linux root" "$DISK"

mkfs.fat -F 32 -n efi "${DISK}1"
mkfs.ext4 -L "NixOS-Root" "${DISK}2"

echo '[*] Mounting partitions...'
mount "${DISK}2" /mnt
mkdir -p /mnt/boot
mount -o umask=077 "${DISK}1" /mnt/boot

nixos-generate-config --root /mnt
cp ~/shared/dotfiles/nix/hosts/vm/configuration.nix /mnt/etc/nixos/configuration.nix

echo '[*] Installing NixOS...'
nixos-install --no-root-passwd

if [ $? -eq 0 ]; then
  reboot
else
  echo '[!] Install failed.'
fi

