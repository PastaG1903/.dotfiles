#!/bin/bash

echo "This script is for installing Arch Linux in UEFI mode."
echo "By proceeding, all the information inside your target disk will be erased."
echo "Do you want to proceed? [Y/n] "
read proceed

if [ "$proceed" = "n" ] || [ "$proceed" = "N" ]; then
  echo ""
else
  iwctl
  echo ""

  lsblk
  echo""

  printf "What is the shown name of the device?\n"
  read target

  continents=$(printf "America/\nEurope/\nAsia/\nAustralia/\nAfrica/")
  parentplace=$(gum filter $continents --header "Choose your timezone:")
  place=$(gum filter $(lsd -1F /usr/share/zoneinfo/$parentplace) --header "Choose your timezone:")
  if [ "${place: -1}" = "/" ]; then
      subplace=$(gum filter $(lsd -1F /usr/share/zoneinfo/$parentplace$place) --header "Choose your timezone:")
      place=$place$subplace
  fi

  timezon=$parentplace$place

  timedatectl set-timezone $timezon

  if [ "$target" = "nvme0n1" ]; then
    house=$target"p4"
    rootp=$target"p3"
    suap=$target"p2"
    efip=$target"p1"
  else
    house=$target"4"
    rootp=$target"3"
    suap=$target"2"
    efip=$target"1"
  fi

  options=$(printf "Yes\nNo")
  sephome=$(gum choose $options --header "Do you want a separate home partition? Default: No")
  if [ "$sephome" != "Yes" ]; then
    sephome="No"
  fi

  printf "\n\nWhat size do you want for ESP? (e.g. 1G, 512M)\n"
  read espsize

  swapops=$(printf "Partition\nSwapfile\nzram")
  swapornot=$(gum choose swapops --header "Please choose your swap choice. If you don't want swap, you can select zram or none")

  if [ "$swapornot" != "zram" ] || [ "$swapornot" != "" ]; then
    printf "\nWhat size do you want for $swapornot? (e.g. 4G, 8G)\n"
    read swapsize
  fi


  if [ "$sephome" = "Yes" ] && [ "$swapornot" = "Partition" ]; then
    printf "What size do you want for ROOT? (e.g. 20G, 50G)\n"
    read rootsize
    printf "g\nn\n\n\n+$espsize\nn\n\n\n+$swapsize\nn\n\n\n+$rootsize\nn\n\n\n\nt\n1\n1\nt\n2\nswap\nt\n3\n23\nt\n4\n23\nw\n" | fdisk /dev/$target

    mkfs.fat -F 32 /dev/$efip
    mkswap /dev/$suap
    mkfs.ext4 /dev/$rootp
    mkfs.ext4 /dev/$house

    swapon /dev/$suap
    mount /dev/$rootp /mnt
    mkdir /mnt/boot
    mount /dev/$efip /mnt/boot
    mkdir /mnt/home
    mount /dev/$house /mnt/home

  elif [ "$sephome" = "No" ] && [ "$swapornot" = "Partition" ]; then
    printf "g\nn\n\n\n+$espsize\nn\n\n\n+$swapsize\nn\n\n\n\nt\n1\n1\nt\n2\nswap\nt\n3\n23\nw\n" | fdisk /dev/$target

    mkfs.fat -F 32 /dev/$efip
    mkswap /dev/$suap
    mkfs.ext4 /dev/$rootp

    swapon /dev/$suap
    mount /dev/$rootp /mnt
    mkdir /mnt/boot
    mount /dev/$efip /mnt/boot

  elif [ "$sephome" = "No" ] && [ "$swapornot" != "Partition" ]; then
    printf "g\nn\n\n\n+$espsize\nn\n\n\n\nt\n1\n1\nt\n2\n23\nw\n" | fdisk /dev/$target

    mkfs.fat -F 32 /dev/$efip
    mkfs.ext4 /dev/$suap

    mount /dev/$suap /mnt
    mkdir /mnt/boot
    mount /dev/$efip /mnt/boot

  else
    printf "What size do you want for ROOT? (e.g. 20G, 50G)\n"
    read rootsize
    printf "g\nn\n\n\n+$espsize\nn\n\n\n+$rootsize\nn\n\n\n\nt\n1\n1\nt\n2\n23\nt\n3\n23\nw\n" | fdisk /dev/$target

    mkfs.fat -F 32 /dev/$efip
    mkfs.ext4 /dev/$suap
    mkfs.ext4 /dev/$rootp

    mount /dev/$suap /mnt
    mkdir /mnt/boot
    mount /dev/$efip /mnt/boot
    mkdir /mnt/home
    mount /dev/$rootp /mnt/home

  fi

  if [ "$swapornot" = "Swapfile" ]; then
    mkswap -U clear --size $swapsize --file /mnt/swapfile
    swapon /mnt/swapfile
  fi

  printf "What kernels would you like from the following? Please separate by spaces (default: linux)\n\nlinux\nlinux-lts\nlinux-rt\nlinux-rt-lts\nlinux-zen\n\n"
  read kernels

  if [ "$kernels" = "" ]; then
    kernels="linux"
  fi

  printf "The following packages will be installed:\nbase\nkernels: $kernels\nlinux-firmware\nsudo\nvim\niwd\nnetworkmanager\nopenssh\nman-pages"

  printf "What other packages do you want to include? (leave blank for none)\n\n"
  read packages

  processor=$(gum choose "intel\namd")"-ucode"

  pacstrap -K /mnt base base-devel $kernels linux-firmware openssh sudo iwd vim networkmanager man-pages $packages $processor

  # pacstrap /mnt tmux fastfetch btop cups git base-devel yazi iwd dhcpcd neovim man-pages pulseaudio blueman xorg

  genfstab -U /mnt >>/mnt/etc/fstab

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

  if [ "$swapornot" = "zram" ]; then
    pacstrap /mnt zram-generator
    printf "[zram0]\nzram-size = min(ram / 2)\ncompression-algorithm = zstd" >> /mnt/etc/systemd/zram-generator.conf
    printf "systemctl daemon-reload && systemctl enable --now systemd-zram-setup@zram0.service" | arch-chroot /mnt
  fi

  clear
  
  printf "\nThe installation is now complete.\nFeel free to use arch-chroot to tune up your installation before rebooting.\nOtherwise, feel free to [reboot now]."
fi
