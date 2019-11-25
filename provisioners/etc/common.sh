
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

  cd $HOME/.config
  if [ ! -e $HOME/.config/$1 ]; then
    _infoStatus "Linking"
    ln -sf $SOURCE_DIR/home/.config/$1 .
  else
    _infoStatus "$HOME/.config/$1 exists"
    rm $1
    ln -sf $SOURCE_DIR/home/.config/$1 .
  fi
  cd - > /dev/null
}

function link_file() {
  _infoStart "Link File $1"
  if [ ! -e $SOURCE_DIR/home/$1 ]; then
    _err "$1 doesn't exist in $SOURCE_DIR/home/"
    exit 1
  fi

  cd $HOME/
  if [ ! -e $HOME/$1 ]; then
    _infoStatus "Linking"
    ln -sf $SOURCE_DIR/home/$1 .
  else
    _infoStatus "$HOME/$1 exists"
    rm $1
    ln -sf $SOURCE_DIR/home/$1 .
  fi
  cd - > /dev/null
}
