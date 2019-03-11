# Super Dot Files
export SDF_PATH=$(dirname `dirname $(realpath ~/.profile)`)
export GOPATH="$HOME/opt/go-workspace"
export PATH="$GOPATH/bin:$SDF_PATH/bin:./docker/bin:./bin/:$PATH"

export EDITOR='vim'
export SHELL='/usr/bin/zsh'

export SDF_BUILT_IN_DISPLAY="eDP1"

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

alias dc='docker-compose'
alias dcr='docker-compose run --rm'

alias ssc='sudo systemctl'
alias mpc-yt='google-chrome "https://www.youtube.com/results?search_query=`mpc | head -n 1`"'
