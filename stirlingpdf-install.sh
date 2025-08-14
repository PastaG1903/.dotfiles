#!/bin/sh

sudo apt-get update
sudo apt-get install -y git automake autoconf libtool libleptonica-dev pkg-config zlib1g-dev make g++ openjdk-21-jdk python3 python3-pip

mkdir ~/.git
cd ~/.git
git clone https://github.com/agl/jbig2enc.git
cd jbig2enc
./autogen.sh
./configure
make
sudo make install

sudo apt-get install -y libreoffice-writer libreoffice-calc libreoffice-impress tesseract-ocr
pip3 install uno opencv-python-headless unoserver pngquant WeasyPrint --break-system-packages

cd ~/Downloads/
wget https://files.stirlingpdf.com/Stirling-PDF.jar
sudo mkdir /opt/Stirling-PDF
sudo mv ~/Downloads/Stirling-PDF.jar /opt/Stirling-PDF
git clone https://github.com/Stirling-Tools/Stirling-PDF
sudo mv ./Stirling-PDF/scripts/ /opt/Stirling-PDF/
sudo rm -r ./Stirling-PDF
