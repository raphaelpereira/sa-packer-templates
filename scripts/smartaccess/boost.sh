#!/bin/bash

set -e
set -x

cd /usr/local/smartaccess
sudo chroot besav2rx-dev-filesystem/ apt-get install -y libbz2-dev libssl-dev
sudo git clone https://github.com/boostorg/boost.git --branch boost-1.61.0 --single-branch --depth 1 besav2rx-dev-filesystem/root/boost

sudo chroot besav2rx-dev-filesystem/ "
cd /root/boost
./bootstrap
./b2 install
cd ..
rm -rf boost
"
cd ~
