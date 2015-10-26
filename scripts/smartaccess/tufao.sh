#!/bin/bash

set -e
set -x

git clone https://github.com/vinipsmaker/tufao.git
cd tufao
cmake .
make
sudo make install
make clean
cd ..
rm -rf tufao
sudo ldconfig
