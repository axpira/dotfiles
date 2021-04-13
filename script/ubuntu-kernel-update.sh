#!/bin/bash

cd $(mktemp -d)

wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.11.7/amd64/linux-headers-5.11.7-051107_5.11.7-051107.202103171746_all.deb
wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.11.7/amd64/linux-headers-5.11.7-051107-generic_5.11.7-051107.202103171746_amd64.deb
wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.11.7/amd64/linux-image-unsigned-5.11.7-051107-generic_5.11.7-051107.202103171746_amd64.deb
wget -c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.11.7/amd64/linux-modules-5.11.7-051107-generic_5.11.7-051107.202103171746_amd64.deb

sudo dpkg -i *.deb
