#!/run/current-system/sw/bin/bash

DISK=/dev/nvme0n1

PASSWORD='horse'

read -p '[!!!] Press enter to continue, this will erase your drive!'

echo '[*] Making partitions...'
parted $DISK -- mklabel gpt
parted $DISK -- mkpart root ext4 512MB -8GB
parted $DISK -- mkpart swap linux-swap -8GB 100%
parted $DISK -- mkpart ESP fat32 1MB 512MB
parted $DISK -- set 3 esp on

echo '[*] Formatting partitions...'
mkfs.fat -F 32 -n boot "${DISK}p3"
echo -n "${PASSWORD}" | cryptsetup luksFormat --type luks2 --label="NixOS-Encrypted" "${DISK}p1" -
cryptsetup config "${DISK}p1" --label "NixOS-Encrypted"
echo -n "${PASSWORD}" | cryptsetup open "${DISK}p1" cryptroot -
mkfs.ext4 -L "NixOS-Root" /dev/mapper/cryptroot
mkswap -L "NixOS-Swap" "${DISK}p2"

echo '[*] Mounting partitions...'
mount /dev/mapper/cryptroot /mnt
mkdir -p /mnt/boot
mount -o umask=077 "${DISK}p3" /mnt/boot
swapon "${DISK}p2"

echo '[*] Installing NixOS...'
nixos-install --no-root-passwd --flake ~/dotfiles/nix#tethys

if [ $? -eq 0 ]; then
  reboot
else
  echo '[!] Install failed.'
fi

