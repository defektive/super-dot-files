#! /bin/bash

if [ -z $SOURCE_DIR ]; then
  # determine script path
  pushd $(dirname `dirname $0`) > /dev/null
  SOURCE_DIR=`pwd`
  popd > /dev/null
fi

source $SOURCE_DIR/provisioners/etc/common.sh

cd $HOME
mkdir -p .config

link_file .ncmpcpp
link_file .gdbinit
link_file .gitconfig
link_file .gitignore_global
link_file .profile
link_file .toprc
link_file .Xresources
link_file .zshrc

link_config bspwm
link_config gtk-3.0
link_config personal
link_config polybar
link_config sxhkd
link_config wallpaper
#link_config yay

if [ ! -d $HOME/.config/oh-my-zsh ]; then
  cd $HOME/.config/
  git clone https://github.com/robbyrussell/oh-my-zsh.git
  cd -
fi

sudo chsh -s /usr/bin/zsh `whoami`
