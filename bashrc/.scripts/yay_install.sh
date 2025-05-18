sudo pacman -S --needed git base-devel
cd ~/Desktop/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
