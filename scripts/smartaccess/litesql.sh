#!/bin/bash

set -e
set -x

sudo apt-get install -y libpq-dev:armel libmysqlclient-dev:armel debhelper autotools-dev libsqlite3-dev:armel automake libexpat1-dev:armel

git clone git://git.code.sf.net/p/litesql/litesql litesql

cd litesql
cat debian/control | sed -se 's/i386 amd64/i386 amd64 armel/g' > debian/control.new && mv debian/control.new debian/control
cat debian/control |sed -se 's/.= 0.3.9.//g' >debian/control.new && mv debian/control.new debian/control
cat configure.ac |sed -se 's/AC_FUNC_MALLOC/#AC_FUNC_MALLOC/g' >configure.ac.new && mv configure.ac.new configure.ac
cat configure.ac |sed -se 's/AC_FUNC_REALLOC/#AC_FUNC_REALLOC/g' >configure.ac.new && mv configure.ac.new configure.ac

# armel
dpkg-buildpackage -a armel -us -uc
sudo dpkg -i ../liblitesql*armel.deb

# clean
cd ..
rm -rf *litesql*
sudo apt-get remove -y libpq-dev:armel libmysqlclient-dev:armel debhelper autotools-dev libsqlite3-dev:armel automake libexpat1-dev
sudo apt-get autoremove -y
