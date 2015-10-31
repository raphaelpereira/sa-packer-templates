#!/bin/bash

set -e
set -x

git clone https://github.com/vinipsmaker/tufao.git

# x86
mkdir tufao_x86
cd tufao_x86
cmake ../tufao
make
sudo make install
make clean
cd ..
rm -rf tufao_x86
sudo ldconfig

# ARM
mkdir tufao_armel
cd tufao_armel
tee -a <<EOF >toolchain.cmake
INCLUDE(CMakeForceCompiler)

# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(Qt5Core_DIR /usr/local/smartaccess/besav2rx-dev-filesystem/usr/local/smartaccess/qt5/lib/cmake/Qt5Core/)
set(Qt5Network_DIR /usr/local/smartaccess/besav2rx-dev-filesystem/usr/local/smartaccess/qt5/lib/cmake/Qt5Network/)

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

cmake -DCMAKE_INSTALL_PREFIX=/usr/local/smartaccess/besav2rx-dev-filesystem/usr/local -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake ../tufao
make
sudo make install
make clean
cd ..
rm -rf tufao_armel
rm -rf tufao
