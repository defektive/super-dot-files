#! /bin/bash
BIN_DIR=`dirname $(realpath $0)`
MY_PATH=`realpath ${BIN_DIR}/../home`

#curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh
#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cp -vrs --remove-destination $MY_PATH/ ~/

rm $HOME/.ncmpcpp
ln -s $MY_PATH/.ncmpcpp ~/

for file in `ls -A $MY_PATH/.config/`; do
  if [ -d $MY_PATH/.config/$file ]; then
    rm $HOME/.config/$file
    ln -s $MY_PATH/.config/$file ~/.config
  fi
done

#sudo ln -s $BIN_DIR/sdf_monitors /user/local/bin/
#sudo ln -s $MY_PATH/../root/etc/udev/99_hotplug_monitors.rules /etc/udev/
