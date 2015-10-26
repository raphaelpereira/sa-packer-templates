#!/bin/bash

set -e
set -x

git clone git://anongit.kde.org/qca.git || git clone https://github.com/KDE/qca.git
cd qca
cmake -DQCA_SUFFIX=qt5 .
make
sudo make install
make clean
cd ..
rm -rf qca
sudo ldconfig
