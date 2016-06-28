#!/bin/bash

set -e
set -x

sudo apt-get install -y build-essential doxygen ssh-askpass ssh-askpass-gnome git gitk git-gui pkg-config libssl-dev \
                        libgps-dev gpsd gdb gdbserver qt5-default cmake qt5-qmake qt5-doc qmlscene qtcreator qtcreator-doc \
                        libqt5serialport5-dev qtpositioning5-dev libqt5webkit5-dev

cd /usr/local/smartaccess
sudo chroot besav2rx-dev-filesystem/ apt-get update
sudo chroot besav2rx-dev-filesystem/ apt-get install --no-install-recommends -y libsqlite3-dev zlib1g-dev zlib1g \
                                                                                libstdc++-4.9-dev libstdc++6 libasound2-dev \
                                                                                libpng12-dev libsystemd-dev libsystemd0 \
                                                                                libssl-dev libproxy-dev libsystemd-journal-dev \
                                                                                libdbus-1-dev libfontconfig1-dev libjpeg-dev \
                                                                                libgps-dev
sudo chroot besav2rx-dev-filesystem/ apt-get clean
cd ~
git clone https://github.com/qtproject/qtbase.git --branch 5.3.2 --single-branch --depth 1
cd qtbase
#curl -O http://www.rmi.inf.br/downloads/linux-imx23-besav2rx.tar.gz
tar xzf /home/vagrant/linux-imx23-besav2rx.tar.gz
rm -f /home/vagrant/linux-imx23-besav2rx.tar.gz
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

tee -a <<EOF >qtcreator_no_opengl
#!/bin/sh
qtcreator -noload Welcome -noload QmlDesigner -noload QmlProfiler
EOF
sudo mv qtcreator_no_opengl /usr/local/bin
sudo chmod a+x /usr/local/bin/qtcreator_no_opengl

#curl -O http://www.rmi.inf.br/downloads/vagrant-qtcreator-config.tar.gz
tar xzf /home/vagrant/vagrant-qtcreator-config.tar.gz
rm -f /home/vagrant/vagrant-qtcreator-config.tar.gz
