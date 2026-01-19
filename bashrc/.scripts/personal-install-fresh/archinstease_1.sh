#!/bin/bash

iwctl
echo ""

timezon="Etc/GMT-6"
timedatectl set-timezone $timezon

mkfs.btrfs -L rootfs /dev/nvme0n1p2

mount /dev/nvme0n1p2 /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@var_log
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@tmp

umount /mnt

mount -o subvol=@,compress=zstd,discard=async /dev/nvme0n1p2 /mnt

mkdir -p /mnt/var/log
mount -o subvol=@var_log,compress=zstd,discard=async /dev/nvme0n1p2 /mnt/var/log

mkdir -p /mnt/var/cache
mount -o subvol=@cache,compress=zstd,discard=async /dev/nvme0n1p2 /mnt/var/cache

mkdir -p /mnt/tmp
mount -o subvol=@tmp,compress=zstd,discard=async /dev/nvme0n1p2 /mnt/tmp

mkdir -p /mnt/.snapshots
mount -o subvol=@snapshots /dev/nvme0n1p2 /mnt/.snapshots

mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
mkdir /mnt/home
mount /dev/nvme0n1p3 /mnt/home

pacstrap -K /mnt base base-devel zram-generator linux-zen linux-rt-lts linux-firmware linux-zen-headers linux-rt-lts-headers openssh sudo iwd vim networkmanager man-pages amd-ucode btrfs-progs grub-btrfs

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
