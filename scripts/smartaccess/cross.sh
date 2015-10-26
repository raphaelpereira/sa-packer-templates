#!/bin/bash

set -e
set -x

sudo apt-get install -y curl

sudo tee -a /etc/apt/sources.list.d/crosstools.list << EOF
deb http://emdebian.org/tools/debian/ jessie main
EOF

curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | sudo apt-key add -
sudo dpkg --add-architecture armel
sudo apt-get update
sudo apt-get install -y gdb-multiarch binutils-multiarch crossbuild-essential-armel
