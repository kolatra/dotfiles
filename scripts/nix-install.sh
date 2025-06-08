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

nixos-generate-config --root /mnt
nix-env -iA nixos.neovim
echo 'Please run nvim /mnt/etc/nixos/configuration.nix to add required software.'
echo 'Automated config installation is not supported yet.'

# when there's an actual config
# git clone https://github.com/kolatra/dotfiles.git
# ln -s ~/dotfiles/nix /mnt/etc/nixos
#
# nixos-install --no-root-passwd

