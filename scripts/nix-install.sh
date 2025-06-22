#!/usr/bin/env bash

DISK=/dev/vda

PASSWORD='horse'

read -p '[!!!] Press enter to continue, this will erase your drive!'

echo '[*] Making partitions...'
sgdisk --zap-all "$DISK"
sgdisk --clear "$DISK"
sgdisk --new=1:0:+512MB --typecode=1:ef00 --change-name=1:"EFI System Partition" "$DISK"
sgdisk --new=2:0:+1GB --typecode=2:8300 --change-name=2:"Linux /boot" "$DISK"
sgdisk --new=3:0:0 --typecode=3:8300 --change-name=3:"Linux root" "$DISK"

echo '[*] Formatting partitions...'
mkfs.fat -F 32 -n efi "${DISK}1"
mkfs.fat -F 32 -n boot "${DISK}2"

echo -n "${PASSWORD}" | cryptsetup luksFormat --label="NixOS-Encrypted" "${DISK}3" -
cryptsetup config "${DISK}3" --label "NixOS-Encrypted"
echo -n "${PASSWORD}" | cryptsetup open "${DISK}3" cryptroot -

mkfs.ext4 -L "NixOS-Root" /dev/mapper/cryptroot

echo '[*] Mounting partitions...'
mount /dev/mapper/cryptroot /mnt
mkdir -p /mnt/boot /mnt/efi
mount -o umask=077 "${DISK}1" /mnt/efi
mount "${DISK}2" /mnt/boot

nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix ~/dotfiles/nix/hosts/server/hardware-configuration.nix

echo '[*] Installing NixOS...'
nixos-install --no-root-passwd --flake ~/dotfiles/nix#titan

# if [ $? -eq 0 ]; then
#   reboot
# else
#   echo '[!] Install failed.'
# fi

