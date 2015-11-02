#!/bin/bash

set -e
set -x

git clone https://github.com/qtproject/qtlocation.git --branch 5.3.2 --depth 1
cd qtlocation
sudo apt-get install -y libgeoclue-dev:armel
/usr/local/smartaccess/qt5/bin/qmake qtlocation.pro 
make
sudo make install
cd ..
rm -rf qtlocation
