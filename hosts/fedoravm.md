# fedoravm changelog

Ginormous install all the things. this should be updated to reflect changes below.
```
sudo dnf groupinstall "Development Tools"

sudo dnf install \
  vim \
  zsh \
  xcb-util-devel \          # bspwm    
  xcb-util-keysyms-devel \  # bspwm    
  xcb-util-wm-devel \       # bspwm    
  alsa-lib-devel \          # bspwm    
  dmenu rxvt-unicode \      # bspwm      
  terminus-fonts \          # bspwm    
  lsb-core-noarch \         # for atom
  libXScrnSaver \           # for slack (not sure why slack needs a screen saver lib)
  lsb \                     # google chrome
  scrot \                   # screenshots
  rxvt-unicode-256color     

curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## Setup up bspwm
```
sudo dnf install \
  xcb-util-devel \
  xcb-util-keysyms-devel \
  xcb-util-wm-devel \
  alsa-lib-devel \
  dmenu rxvt-unicode \
  terminus-fonts

sudo dnf groupinstall "Development Tools"

mkdir -p ~/development/github.com/{defektive,baskerville,krypt-n}
cd  ~/development/github.com/baskerville
git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git
git clone https://github.com/baskerville/sutils.git
git clone https://github.com/baskerville/xtitle.git
git clone https://github.com/baskerville/xdo.git

cd  ~/development/github.com/baskerville
cd bspwm/ && make && sudo make install
cd ../sxhkd/ && make && sudo make install
cd ../sutils/ && make && sudo make install
cd ../xtitle/ && make && sudo make install
cd ../xdo/ && make && sudo make install

# patched lemonbar
cd ~/development/github.com/krypt-n
cd !:1
git clone https://github.com/krypt-n/bar.git
cd bar && make && sudo make install

# Lemonbar
# mkdir ~/development/github.com/LemonBoy
# cd !:1
# git clone https://github.com/LemonBoy/bar.git
# cd  ~/development/github.com/LemonBoy/bar && make && sudo make install

## setup config
### Add bspwm to the list of xsessions
sudo cp ~/development/github.com/baskerville/bspwm/contrib/freedesktop/bspwm.desktop /usr/share/xsessions/

### setup config files for bspwm and sxhkd
mkdir ~/.config/{bspwm,sxhkd}
cp ~/development/github.com/baskerville/bspwm/examples/bspwmrc ~/.config/bspwm/
cp ~/development/github.com/baskerville/bspwm/examples/sxhkdrc ~/.config/sxhkd/
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/sxhkd/sxhkdrc

sudo cp ~/development/github.com/baskerville/bspwm/examples/panel/profile /etc/profile.d/lemonbar_panel_fifo.sh
cp ~/development/github.com/baskerville/bspwm/examples/panel/panel* ~/.config/bspwm/
chmod +x ~/.config/bspwm/panel*
```
I needed to modify the panels to source each other properly, I didn't feel like adding them to my path.

Should be able to restart and enjoy bspwm. `sudo service gdm restart`

## Update
Probably should have done this in the beginning.
```
sudo dnf update
```

## Setup up mpd
I had to add rpmfusion free, decided to add non-free while I was at it.
```
su -c 'dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'

sudo dnf install mpd mpc ncmpcp
```

### OMFG!!! I need to learn selinux

For now I am just starting mpd when I log in.

## Install spf13 and oh-my-zsh
```
curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## update
```
sudo dnf update
```

## Setup lightdm and disable gdm

```
sudo dnf install lightdm lightdm-gtk
sudo systemctl disable gdm
sudo systemctl enable lightdm
```

## Add icon font
```
git clone https://aur.archlinux.org/ttf-font-icons.git
cd ttf-font-icons
sudo cp icons.ttf /usr/share/fonts/TTF/
```

## Switch to urxvt w/256 colors
```
sudo dnf install rxvt-unicode-256color
```
sxhkdrc will use urxvt256c as its default terminal


## Install compton
used rpm from [opensuse](http://software.opensuse.org/package/compton)
specifically: http://download.opensuse.org/repositories/openSUSE:/Factory/standard/x86_64/compton-0.1.0-2.4.x86_64.rpm
```
sudo rpm -Uvh compton-0.1.0-2.4.x86_64.rpm
```

## install scrot
```
sudo dnf install scrot
```
