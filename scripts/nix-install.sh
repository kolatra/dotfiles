#!/run/current-system/sw/bin/bash

echo '[*] Making partitions...'
parted /dev/vda -- mklabel gpt
parted /dev/vda -- mkpart root ext4 512MB -8GB
parted /dev/vda -- mkpart swap linux-swap -8GB 100%
parted /dev/vda -- mkpart ESP fat32 1MB 512MB
parted /dev/vda -- set 3 esp on

echo '[*] Formatting partitions...'
mkfs.ext4 -L nixos /dev/vda1
mkswap -L swap /dev/vda2
mkfs.fat -F 32 -n boot /dev/vda3

echo '[*] Mounting partitions...'
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

echo '[*] Updating hardware config...'

mkdir -p /mnt/etc/nixos
cp ~/dotfiles/laptop/* /mnt/etc/nixos
rm /mnt/etc/nixos/hardware-configuration.nix
nixos-generate-config --root /mnt

echo '[*] Installing NixOS...'
nixos-install

read -p "Press any key to restart the system"
reboot

