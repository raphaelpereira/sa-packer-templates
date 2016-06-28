#!/bin/bash

set -e
set -x

sudo bash -c 'echo "using gcc : arm : arm-linux-gnueabi-g++ ;" > /etc/site-config.jam'

if [[ ! -e boost.tar.bz2 ]]; then
        wget -O boost.tar.bz2 http://downloads.sourceforge.net/project/boost/boost/1.61.0/boost_1_61_0.tar.bz2?use_mirror=ufpr
fi
tar xjf boost.tar.bz2
mv boost_1_61_0 boost
sudo chroot /usr/local/smartaccess/besav2rx-dev-filesystem/ apt-get install -y libbz2-dev libssl-dev

# Boost for ARM
cd boost
./bootstrap.sh
sudo ./b2 toolset=gcc-arm install --prefix=/usr/local/smartaccess/besav2rx-dev-filesystem/usr/local || true
sudo ./b2 clean

# Boost for x86_64
sudo rm -f /etc/site-config.jam
sudo ./b2 toolset=gcc install || true
cd ~
sudo rm -rf boost*

