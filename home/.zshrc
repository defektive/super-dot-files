source $HOME/.profile
export ZSH="$HOME/.config/oh-my-zsh"
export ZSH_THEME="robbyrussell"

if [ -f $HOME/.config/personal/pre.zshrc ]; then
  source $HOME/.config/personal/pre.zshrc
fi

source $ZSH/oh-my-zsh.sh

if [ -f $HOME/.config/personal/post.zshrc ]; then
  source $HOME/.config/personal/post.zshrc
fi
