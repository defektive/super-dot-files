if [ -f $HOME/.config/personal/pre.profile ]; then
  source $HOME/.config/personal/pre.profile
fi


# Super Dot Files
export SDF_PATH=$(dirname `dirname $(realpath ~/.profile)`)
export GOPATH="$HOME/opt/go-workspace"
export PATH="$GOPATH/bin:$SDF_PATH/bin:./docker/bin:./bin/:$PATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR='vim'
export SHELL='/usr/bin/zsh'

if  [ "$TERM" = "xterm-termite" ]; then
    alias ssh='TERM=xterm-color ssh'
fi

if [ "$SSH_AGENT_PID" = "" ]; then
  eval `ssh-agent`
fi
echo $SSH_AGENT_PID

# add core_perl to path if it exists
if [ -d "/usr/bin/core_perl" ] ; then
  PATH="/usr/bin/core_perl:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.gem/ruby/2.6.0/bin" ] ; then
    PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
fi

if [ -f $HOME/.config/personal/post.profile ]; then
  source $HOME/.config/personal/post.profile
fi
