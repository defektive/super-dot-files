# rubymine *needs* oracle JDK... psh it didnt need it on archlinux
export RUBYMINE_JDK="/usr/java/latest/"
export WEBIDE_JDK="/usr/java/latest/"
#source /usr/local/share/chruby/chruby.sh
#source /usr/local/share/chruby/auto.sh
RUBIES+=(
    "$HOME/.rubies"
)

export GOPATH="$HOME/development/go-workspace"
alias dc=docker-compose
alias dcr=docker-compose run --rm
alias mpc-yt='google-chrome "https://www.youtube.com/results?search_query=`mpc | head -n 1`"'

# bspwm java gui fix
export _JAVA_AWT_WM_NONREPARENTING=1
SDF_PATH=`dirname $(realpath ~/.zshrc)`

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
export PATH="$GOPATH/bin:$SDF_PATH/bin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:$HOME/bin:$HOME/bin:/bin:/sbin"
source $ZSH/oh-my-zsh.sh
export EDITOR='vim'

if [ "$TTY" = "/dev/tty1" ]; then
    echo "Initiating login sequence...";
    eval `ssh-agent`
    ssh-add ~/.ssh/instructure_rsa
fi
