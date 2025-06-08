#!/run/current-system/sw/bin/bash

# make partitions
parted /dev/vda -- mklabel gpt
parted /dev/vda -- mkpart root ext4 512MB -8GB
parted /dev/vda -- mkpart swap linux-swap -8GB 100%
parted /dev/vda -- mkpart ESP fat32 1MB 512MB
parted /dev/vda -- set 3 esp on

# format partitions
mkfs.ext4 -L nixos /dev/vda1
mkswap -L swap /dev/vda2
mkfs.fat -F 32 -n boot /dev/vda3

# install
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

mkdir -p /mnt/bin
ln -s /run/current-system/sw/bin/bash /mnt/bin/bash

cp -r ~/dotfiles/laptop /mnt/etc/nixos
rm /mnt/etc/nixos/hardware-configuration.nix
nixos-generate-config --root /mnt

nixos-install
reboot

