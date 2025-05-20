#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Monterrey /etc/localtime # change accordingly
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
touch /etc/locale.conf
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

mkinitcpio -P

touch /etc/hostname
echo "$1" >> /etc/hostname

printf "$2\n$2\n" | passwd

pacman -S --noconfirm --needed grub efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch_GRUB
grub-mkconfig -o /boot/grub/grub.cfg

mkdir -p /boot/EFI/BOOT
cp /boot/EFI/Arch_GRUB/grubx64.efi /boot/EFI/BOOT/BOOTX64.EFI

# At this point, it is suggested to install a DE if desired
# Plasma is the DE by default. Replace it with one of your choosing if needed
# By default, the line below has sddm as the display manager
# Replace sddm with gdm if using GNOME DE and remove sddm-kcm
# Additionally, kitty is set as the default terminal emulator

# pacman -S --noconfirm --needed sddm sddm-kcm wayland plasma kitty
# pacman -S --noconfirm gdm wayland gnome gnome-tweaks wezterm

# systemctl enable NetworkManager bluetooth cups sshd
# systemctl enable sddm

useradd -m -G wheel "$3"

printf "$4\n$4\n" | passwd "$3"

touch /etc/sudoers.d/00_$3
echo "$3 ALL=(ALL) ALL" >> /etc/sudoers.d/00_$3
chmod 0440 /etc/sudoers.d/00_$3

echo "$3 has been granted the rank of sudoer "
