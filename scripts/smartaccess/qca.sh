#!/bin/bash

set -e
set -x

git clone git://anongit.kde.org/qca.git || git clone https://github.com/KDE/qca.git
cd qca
git checkout v2.1.1
cd ..

# x86
mkdir qca_x86
cd qca_x86
cmake -DQCA_SUFFIX=qt5 ../qca
make
sudo make install
make clean
cd ..
rm -rf qca_x86
sudo ldconfig

# ARM
mkdir qca_armel
cd qca_armel
tee -a <<EOF >toolchain.cmake
INCLUDE(CMakeForceCompiler)

# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(Qt5Core_DIR /usr/local/smartaccess/besav2rx-dev-filesystem/usr/local/smartaccess/qt5/lib/cmake/Qt5Core/)
set(Qt5Network_DIR /usr/local/smartaccess/besav2rx-dev-filesystem/usr/local/smartaccess/qt5/lib/cmake/Qt5Network/)
set(Qt5Test_DIR /usr/local/smartaccess/besav2rx-dev-filesystem/usr/local/smartaccess/qt5/lib/cmake/Qt5Test/)

# specify the cross compiler
SET(CMAKE_C_COMPILER   arm-linux-gnueabi-gcc)
SET(CMAKE_CXX_COMPILER arm-linux-gnueabi-g++)

# where is the target environment
SET(CMAKE_FIND_ROOT_PATH  /usr/local/smartaccess/besav2rx-dev-filesystem)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
EOF

cmake -DCMAKE_INSTALL_PREFIX=/usr/local/smartaccess/besav2rx-dev-filesystem/usr/local -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake -DQCA_SUFFIX=qt5 ../qca
make
sudo make install
make clean
cd ..
rm -rf qca_armel
rm -rf qca
