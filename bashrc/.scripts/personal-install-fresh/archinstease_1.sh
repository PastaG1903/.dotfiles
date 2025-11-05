#!/bin/bash

iwctl
echo ""

timezon="Etc/GMT-6"
timedatectl set-timezone $timezon


espsize="1G"

swapornot="zram"

rootsize="100G"

printf "g\nn\n\n\n+$espsize\nn\n\n\n+$rootsize\nn\n\n\n\nt\n1\n1\nt\n2\n23\nt\n3\n23\nw\n" | fdisk /dev/$target

mkfs.fat -F 32 /dev/nvme0n1p1
mkfs.btrfs /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3

mount /dev/nvme0n1p2 /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
mkdir /mnt/home
mount /dev/nvme0n1p3 /mnt/home

pacstrap -K /mnt base base-devel zram-generator linux-zen linux-rt-lts linux-firmware openssh sudo iwd vim networkmanager man-pages amd-ucode $packages

genfstab -U /mnt >> /mnt/etc/fstab

printf "[zram0]\nzram-size = ram / 2\ncompression-algorithm = zstd" >> /mnt/etc/systemd/zram-generator.conf

printf "\nWhat should be the hostname for this installation?\n"
read hostneimu

printf "\nWhat should the root password be?\n"
read pasvordo

printf "\nLet's make you a user. What should it be?\n"
read neimu

printf "\nWhat should be the password?\n"
read passvordo

mv /mount/archinstease_2.sh /mnt/mnt

printf "/mnt/archinstease_2.sh $hostneimu $pasvordo $neimu $passvordo $timezon" | arch-chroot /mnt

rm /mnt/mnt/archinstease_2.sh
