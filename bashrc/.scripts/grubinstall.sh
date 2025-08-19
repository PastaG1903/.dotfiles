#!/bin/bash

pacman -S --noconfirm --needed grub efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch_GRUB
grub-mkconfig -o /boot/grub/grub.cfg

mkdir -p /boot/EFI/BOOT
cp /boot/EFI/Arch_GRUB/grubx64.efi /boot/EFI/BOOT/BOOTX64.EFI
