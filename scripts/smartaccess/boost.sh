#!/bin/bash

set -e
set -x

echo "
#!/bin/bash
cd /root/boost
./bootstrap.sh
./b2 install
cd ..
rm -rf boost
" > make_boost
chmod 777 make_boost
sudo mv make_boost /usr/local/smartaccess/besav2rx-dev-filesystem/
wget -O boost.tar.bz2 http://downloads.sourceforge.net/project/boost/boost/1.61.0/boost_1_61_0.tar.bz2
tar xjf boost.tar.bz2
mv boost_1_61_0 boost
sudo mv boost /usr/local/smartaccess/besav2rx-dev-filesystem/root
cd /usr/local/smartaccess
sudo chroot besav2rx-dev-filesystem/ apt-get install -y libbz2-dev libssl-dev
sudo chroot besav2rx-dev-filesystem/ /make_boost
sudo rm -rf besav2rx-dev-filesystem/make_boost

cd ~
