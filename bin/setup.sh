#! /bin/sh

BIN_DIR=`dirname $(realpath $0)`
MY_PATH=`realpath ${BIN_DIR}/../`


# curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


ln -s $MY_PATH/.Xresources ~/
ln -s $MY_PATH/.xinitrc ~/
ln -s $MY_PATH/.toprc ~/
ln -s $MY_PATH/.gitconfig ~/
ln -s $MY_PATH/.gitignore_global ~/
ln -s $MY_PATH/.vimrc.local ~/

mkdir ~/.config/
ln -s $MY_PATH/.config/sxhkd ~/.config/
ln -s $MY_PATH/.config/bspwm ~/.config/

rm ~/.zshrc
ln -s $MY_PATH/.zshrc ~/
