# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export EDITOR='vim'

# Super Dot Files
export SDF_PATH=`dirname $(realpath ~/.profile)`
export GOPATH="$HOME/development/"
export PATH="$GOPATH/bin:$SDF_PATH/bin:$HOME/bin:$HOME/.local/bin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

export PATH=/home/CORP.INSTRUCTURE.COM/bhorrocks/.gem/ruby/2.3.0/bin:$PATH

alias dc='docker-compose'
alias dcr='docker-compose run --rm'
alias ssc='sudo systemctl'
alias mpc-yt='google-chrome "https://www.youtube.com/results?search_query=`mpc | head -n 1`"'

# rubymine *needs* oracle JDK... psh it didnt need it on archlinux
# export RUBYMINE_JDK="/usr/java/latest/"
# export WEBIDE_JDK="/usr/java/latest/"
source /usr/share/chruby/chruby.sh
source /usr/share/chruby/auto.sh
RUBIES+=(
    "$HOME/.rubies"
)

# bspwm java gui fix
export _JAVA_AWT_WM_NONREPARENTING=1
setopt extended_glob
