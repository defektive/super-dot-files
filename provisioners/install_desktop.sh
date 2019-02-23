#! /bin/bash

if [ -z $SOURCE_DIR ]; then
  # determine script path
  pushd $(dirname `dirname $0`) > /dev/null
  SOURCE_DIR=`pwd`
  popd > /dev/null
fi

# May want to add the following
# xdo \
# xtitle \

## Install desktop
yay --noconfirm -S \
  xorg-server \
  xorg-xinit \
  libnotify \
  dunst \
  dmenu \
  sxhkd \
  xf86-video-fbdev \
  xf86-video-vesa \
  xf86-video-intel \
  google-chrome \
  firefox \
  ttf-dejavu bspwm \
  compton \
  feh \
  bc \
  xorg-xev \
  xorg-xrandr \
  polybar \
  xclip \
  maim \
  ttf-font-icons \
  wireshark-gtk \
  yubikey-personalization-gui \
  yubikey-personalization \
  yubikey-manager \
  keybase \
  kbfs \
  keybase-gui \
  xautolock \
  i3lock \
  termite \
  slack-desktop

$SOURCE_DIR/provisioners/configure_desktop.sh
