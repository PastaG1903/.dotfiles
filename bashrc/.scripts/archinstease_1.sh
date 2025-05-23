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

  echo "Do you want a separate home partition? [y/N] "
  read sephome

  printf "\n\nWhat size do you want for ESP? (e.g. 1G, 512M)\n"
  read espsize

  printf "\nWhat size do you want for SWAP? (e.g. 4G, 8G)\n"
  read swapsize

  if [ "$sephome" = "y" ]; then
    printf "What size do you want for ROOT? (e.g. 20G, 50G)\n"
    read rootsize
    printf "g\nn\n\n\n+$espsize\nn\n\n\n+$swapsize\nn\n\n\n+$rootsize\nn\n\n\n\nt\n1\n1\nt\n2\nswap\nt\n3\n23\nt\n4\n23\nw\n" | fdisk /dev/$target
  else
    printf "g\nn\n\n\n+$espsize\nn\n\n\n+$swapsize\nn\n\n\n\nt\n1\n1\nt\n2\nswap\nt\n3\n23\nw\n" | fdisk /dev/$target
  fi

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

  mkfs.ext4 /dev/$rootp
  mkswap /dev/$suap
  mkfs.fat -F 32 /dev/$efip

  mount /dev/$rootp /mnt
  mkdir /mnt/boot
  mount /dev/$efip /mnt/boot
  swapon /dev/$suap

  if [ "$sephome" = "y" ]; then
    mkfs.ext4 /dev/$house
    mkdir /mnt/home
    mount /dev/$house /mnt/home
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

  git clone https://github.com/PastaG1903/.dotfiles

  mv ./.dotfiles/bashrc/.scripts/iwdtui /mnt/usr/bin

  rm -r ./.dotfiles

  clear
  
  printf "\nThe installation is now complete.\nFeel free to use arch-chroot to tune up your installation before rebooting.\nOtherwise, feel free to [reboot now]."
fi
