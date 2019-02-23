
function _infoStart() {
  echo "[+] $1"
}

function _infoStatus() {
  echo "[-] $1"
}

function _err() {
  echo "[+] $1"
}

function link_config() {
  _infoStart "Link Config $1"
  if [ ! -e $SOURCE_DIR/home/.config/$1 ]; then
    _err "$1 doesn't exist in $SOURCE_DIR/home/.config"
    exit 1
  fi

  if [ ! -e $HOME/.config/$1 ]; then
    _infoStatus "Linking"
    cd $HOME/.config
    ln -s $SOURCE_DIR/home/.config/$1 .
    cd - > /dev/null
  else
    _infoStatus "$HOME/.config/$1 exists"
  fi
}

function link_file() {
  _infoStart "Link File $1"
  if [ ! -e $SOURCE_DIR/home/$1 ]; then
    _err "$1 doesn't exist in $SOURCE_DIR/home/"
    exit 1
  fi

  if [ ! -e $HOME/$1 ]; then
    _infoStatus "Linking"
    cd $HOME/
    ln -s $SOURCE_DIR/home/$1 .
    cd - > /dev/null
  else
    _infoStatus "$HOME/$1 exists"
  fi
}
