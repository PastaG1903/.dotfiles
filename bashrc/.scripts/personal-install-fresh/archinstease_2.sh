#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Monterrey /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

mkinitcpio -P

echo "Write a hostname for thy new system\n"
read hostname 
echo "$hostname" > /etc/hostname

echo "What should be the password?\n"
read pasvord
printf "$pasvord\n$pasvord\n" | passwd

pacman -S --noconfirm --needed grub efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch_GRUB --removable --disable-shim-lock --modules="tpm"
grub-mkconfig -o /boot/grub/grub.cfg

mkdir -p /boot/EFI/BOOT
cp /boot/EFI/Arch_GRUB/grubx64.efi /boot/EFI/BOOT/BOOTX64.EFI

echo "What should your username?\n"
read user

useradd -m -G wheel "$user"

printf "$pasvord\n$pasvord\n" | passwd "$user"

echo "$user ALL=(ALL) ALL" > /etc/sudoers.d/00_$user
chmod 0440 /etc/sudoers.d/00_$user

echo "$user has been granted the rank of sudoer "
sleep 5
