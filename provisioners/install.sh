#! /bin/bash

if [ `whoami` == "vagrant" ]; then
  echo '[!] This is not intended to be run in vagrant'
  # exit 1
fi

# determine script path
pushd $(dirname `dirname $0`) > /dev/null
SOURCE_DIR=`pwd`
popd > /dev/null

sudo $SOURCE_DIR/provisioners/bootstrap.sh
$SOURCE_DIR/provisioners/bootstrap_user.sh
$SOURCE_DIR/provisioners/install_aur.sh

## Additional things
$SOURCE_DIR/provisioners/install_desktop.sh
$SOURCE_DIR/provisioners/install_blackarch.sh
