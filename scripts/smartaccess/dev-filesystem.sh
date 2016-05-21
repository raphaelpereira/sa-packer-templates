#!/bin/bash

set -e
set -x

sudo mkdir /usr/local/smartaccess
cd /usr/local/smartaccess
sudo apt-get install -y debootstrap qemu-user-static binfmt-support libsystemd0:armel libsystemd-journal-dev libssl-dev:armel
sudo debootstrap --foreign --arch=armel jessie besav2rx-dev-filesystem
sudo cp /usr/bin/qemu-arm-static besav2rx-dev-filesystem/usr/bin/
sudo cp /etc/resolv.conf besav2rx-dev-filesystem/etc/
sudo chroot besav2rx-dev-filesystem/ /debootstrap/debootstrap --second-stage
sudo chroot besav2rx-dev-filesystem/ apt-get update
sudo chroot besav2rx-dev-filesystem/ apt-get install libmosquittopp-dev
sudo chroot besav2rx-dev-filesystem/ apt-get clean
cd ~
