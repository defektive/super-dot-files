source ~/.profile

# key bindings
bindkey "e[1~" beginning-of-line
bindkey "e[4~" end-of-line
bindkey "e[5~" beginning-of-history
bindkey "e[6~" end-of-history
bindkey "e[3~" delete-char
bindkey "e[2~" quoted-insert
bindkey "e[5C" forward-word
bindkey "e[5D" backward-word
bindkey "ee[C" forward-word
bindkey "ee[D" backward-word
bindkey "^H" backward-delete-word
# for rxvt
bindkey "e[8~" end-of-line
bindkey "e[7~" beginning-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
plugins=(git wd)
source $ZSH/oh-my-zsh.sh
eval `ssh-agent`

if [ "$TTY" = "/dev/tty1" ]; then
  SDF_STARTX_CMD='bspwm'
fi

if [ "$TTY" = "/dev/tty2" ]; then
  SDF_STARTX_CMD='i3'
fi

if [ "$TTY" = "/dev/tty3" ]; then
  SDF_STARTX_CMD='slack'
fi

export SDF_STARTX_CMD
alias startx='startx 2>&1 > .$SDF_STARTX_CMD.startx.log; exit'
