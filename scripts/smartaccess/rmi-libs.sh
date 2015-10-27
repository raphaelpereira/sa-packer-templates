#!/bin/bash

set -e
set -x

curl -O http://www.rmi.inf.br/downloads/smartaccess-libs.tar.gz
mkdir -p /tmp/smartaccess-libs
cd /tmp/smartaccess-libs
tar xzf /home/vagrant/smartaccess-libs.tar.gz
sudo cp -arf /tmp/smartaccess-libs/usr/local/emdebian-besav1rx-devel/ /usr/local/
sudo cp -arf /tmp/smartaccess-libs/usr/local/include/ /usr/local/emdebian-besav1rx-devel/usr/local/
sudo cp -arf /tmp/smartaccess-libs/usr/local/lib/qt5-arm-linux-gnueabi/ /usr/local/lib/
sudo cp -arf /tmp/smartaccess-libs/usr/local/lib/lib* /usr/local/emdebian-besav1rx-devel/usr/lib/
sudo cp -arf /tmp/smartaccess-libs/usr/local/lib/arm-linux-gnueabi/lib* /usr/local/emdebian-besav1rx-devel/usr/lib/arm-linux-gnueabi/
sudo cp -arf /tmp/smartaccess-libs/usr/local/lib/arm-linux-gnueabi/plugins /usr/local/emdebian-besav1rx-devel/usr/lib/arm-linux-gnueabi/
cd ~
rm -rf /tmp/smartaccess-libs
