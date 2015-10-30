#!/bin/bash

set -e
set -x

sudo mkdir /usr/local/smartaccess
cd /usr/local/smartaccess
sudo apt-get install -y debootstrap qemu-user-static binfmt-support libsystemd0:armel libsystemd-journal-dev
sudo debootstrap --foreign --arch=armel jessie besav2rx-dev-filesystem
sudo cp /usr/bin/qemu-arm-static besav2rx-dev-filesystem/usr/bin/
sudo cp /etc/resolv.conf besav2rx-dev-filesystem/etc/
sudo chroot besav2rx-dev-filesystem/ /debootstrap/debootstrap --second-stage
sudo chroot besav2rx-dev-filesystem/ apt-get update
sudo chroot besav2rx-dev-filesystem/ apt-get install --no-install-recommends -y libsqlite3-dev zlib1g-dev zlib1g \
                                                                                libstdc++-4.9-dev libstdc++6 libasound2-dev \
                                                                                libpng12-dev libsystemd-dev libsystemd0 \
                                                                                libssl-dev libproxy-dev libsystemd-journal-dev \
                                                                                libdbus-1-dev libfontconfig1-dev libjpeg-dev
sudo chroot besav2rx-dev-filesystem/ apt-get clean
cd ~
git clone https://github.com/qtproject/qtbase.git --branch 5.3.2 --single-branch --depth 1
cd qtbase
curl -O http://www.rmi.inf.br/downloads/linux-imx23-besav2rx.tar.gz
tar xzf linux-imx23-besav2rx.tar.gz
rm linux-imx23-besav2rx.tar.gz
./configure -verbose -prefix /usr/local/smartaccess/qt5 \
    -release \
    -opensource -confirm-license \
    -shared \
    -qt-sql-sqlite \
    -plugin-sql-sqlite \
    -system-sqlite \
    -no-qml-debug \
    -dbus \
    -qt-zlib -qt-libpng \
    -journald \
    -qpa linuxfb \
    -device linux-imx23-besav2rx  \
    -device-option CROSS_COMPILE=arm-linux-gnueabi- \
    -sysroot /usr/local/smartaccess/besav2rx-dev-filesystem \
    -optimized-qmake \
    -make libs \
    -system-libpng -system-libjpeg -system-zlib \
    -no-harfbuzz \
    -nomake examples -nomake tests -nomake tools \
    -no-pch -no-iconv -no-nis -no-xkb -no-xshape \
    -no-xsync -no-xcursor -no-xfixes -no-xrandr -no-kms \
    -no-directfb -no-eglfs -no-xcb \
    -no-icu -no-cups -no-gif \
    -no-opengl \
    -no-sql-db2 -no-sql-ibase -no-sql-mysql -no-sql-oci \
    -no-sql-odbc -no-sql-psql -no-sql-sqlite2 

make
sudo make install
cd ..
sudo rm -rf qtbase
