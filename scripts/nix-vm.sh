#!/run/current-system/sw/bin/bash

DISK=/dev/vda

PASSWORD='horse'

read -p '[!!!] Press enter to continue, this will erase your drive!'

echo '[*] Making partitions...'
sgdisk --zap-all "$DISK"
sgdisk --clear "$DISK"
sgdisk --new=1:0:+512MB --typecode=1:ef00 --change-name=1:"EFI System Partition" "$DISK"
sgdisk --new=2:0:0 --typecode=2:8300 --change-name=2:"Linux root" "$DISK"

echo '[*] Formatting partitions...'
mkfs.fat -F 32 -n efi "${DISK}1"

echo -n "${PASSWORD}" | cryptsetup luksFormat --label="NixOS-Encrypted" "${DISK}2" -
cryptsetup config "${DISK}2" --label "NixOS-Encrypted"
echo -n "${PASSWORD}" | cryptsetup open "${DISK}2" cryptroot -

mkfs.ext4 -L "NixOS-Root" /dev/mapper/cryptroot

echo '[*] Mounting partitions...'
mount /dev/mapper/cryptroot /mnt
mkdir -p /mnt/boot
mount -o umask=077 "${DISK}1" /mnt/boot

nixos-generate-config --root /mnt

echo '[*] Installing NixOS...'
nixos-install

if [ $? -eq 0 ]; then
  reboot
else
  echo '[!] Install failed.'
fi

