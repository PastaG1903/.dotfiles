#!/bin/bash

cd
sudo pacman -S --needed --noconfirm $(cat ./packages_essential_pacman.txt)
./yay_install.sh
yay -S --needed --noconfirm $(cat ./packages_essential_pacman.txt)

services=(bluetooth cups dhcpcd keyd NetworkManager sshd tlp zerotier-one wpa_supplicant)

for service in $services; do
  sudo systemctl enable --now "$service"

./pyvenv.sh

git clone https://github.com/vinceliuice/grub2-themes/
cd grub2-themes
sudo ./install.sh -t tela -c 1920x1200 -b

cd
rm -r grub2-themes

../../restow.sh
