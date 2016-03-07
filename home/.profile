# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if  [ "$TERM" = "xterm-termite" ]; then
    alias ssh='TERM=xterm-color ssh'
fi

if [ "$SSH_AGENT_PID" = "" ]; then
  eval `ssh-agent`
  # export SSH_AGENT_PID
  # export SSH_AUTH_SOCK
fi
echo $SSH_AGENT_PID

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
    fi
fi

# add core_perl to path if it exists
if [ -d "/usr/bin/core_perl" ] ; then
  PATH="/usr/bin/core_perl:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.gem/ruby/2.5.0/bin" ] ; then
    PATH="$HOME/.gem/ruby/2.5.0/bin:$PATH"
fi

export EDITOR='vim'
export SHELL='/usr/bin/zsh'

# Super Dot Files
export SDF_PATH=$(dirname `dirname $(realpath ~/.profile)`)
export GOPATH="$HOME/opt/go-workspace"
export PATH="$GOPATH/bin:$SDF_PATH/bin:./docker/bin:./bin/:$PATH"

alias dc='docker-compose'
alias dcr='docker-compose run --rm'
alias ssc='sudo systemctl'
alias mpc-yt='google-chrome "https://www.youtube.com/results?search_query=`mpc | head -n 1`"'

# rubymine *needs* oracle JDK... psh it didnt need it on archlinux
# export RUBYMINE_JDK="/usr/java/latest/"
# export WEBIDE_JDK="/usr/java/latest/"
# source /usr/share/chruby/chruby.sh
# source /usr/share/chruby/auto.sh
# RUBIES+=(
#     "$HOME/.rubies"
# )

# bspwm java gui fix
# export _JAVA_AWT_WM_NONREPARENTING=1
setopt extended_glob
export MPD_HOST=127.0.0.1
