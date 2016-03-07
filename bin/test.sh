#!/bin/bash
# Default acpi script that takes an entry for all actions

pushd `dirname $(realpath $0)` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

echo $SCRIPTPATH
