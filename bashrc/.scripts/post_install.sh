#!/bin/bash

sudo pacman -S --needed --noconfirm $(cat ./packages_essential_pacman.txt)
./yay_install.sh
yay -S --needed --noconfirm $(cat ./packages_essential_pacman.txt)

services=(bluetooth cups dhcpcd keyd NetworkManager sshd tlp zerotier-one wpa_supplicant)

for service in $services; do
  sudo systemctl enable --now "$service"

./pyvenv.sh

../../restow.sh
