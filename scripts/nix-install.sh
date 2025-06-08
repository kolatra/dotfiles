#!/run/current-system/sw/bin/bash

DISK=/dev/vda

echo '[*] Making partitions...'
parted $DISK -- mklabel gpt
parted $DISK -- mkpart root ext4 512MB -8GB
parted $DISK -- mkpart swap linux-swap -8GB 100%
parted $DISK -- mkpart ESP fat32 1MB 512MB
parted $DISK -- set 3 esp on

echo '[*] Formatting partitions...'
mkfs.ext4 -L nixos "${DISK}1"
mkswap -L swap "${DISK}2"
mkfs.fat -F 32 -n boot "${DISK}3"

echo '[*] Mounting partitions...'
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

echo '[*] Updating hardware config...'
mkdir -p /mnt/etc/nixos
cp -r ~/dotfiles/laptop/* /mnt/etc/nixos
rm /mnt/etc/nixos/hardware-configuration.nix
nixos-generate-config --root /mnt

echo '[*] Installing NixOS...'
nixos-install --no-root-passwd

reboot

