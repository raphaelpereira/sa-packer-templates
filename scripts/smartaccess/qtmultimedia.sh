#!/bin/bash

set -e
set -x

git clone https://github.com/qtproject/qtmultimedia.git --branch 5.3.2 --depth 1
cd qtmultimedia
sudo apt-get install -y libasound2-dev:armel
/usr/local/smartaccess/qt5/bin/qmake qtmultimedia.pro 
make
sudo make install
cd ..
rm -rf qtmultimedia
