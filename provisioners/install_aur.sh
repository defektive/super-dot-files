#! /bin/bash


## Install Yaourt
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm -si
cd -
rm -rf yay
