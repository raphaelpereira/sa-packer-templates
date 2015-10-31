#!/bin/bash

set -e
set -x

git clone https://github.com/qtproject/qtserialport.git --branch 5.3.2 --depth 1
cd qtserialport
/usr/local/smartaccess/qt5/bin/qmake qtserialport.pro 
make
sudo make install
cd ..
rm -rf qtserialport
