#!/bin/bash

set -e
set -x

cd /usr/local/smartaccess
sudo chroot besav2rx-dev-filesystem/ apt-get install -y libpcsclite-dev
cd ~
