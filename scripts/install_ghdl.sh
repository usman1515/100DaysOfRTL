#!/bin/bash

# create dir Tools if it doesnt exist
[ -d ~/Tools ] || mkdir -p ~/Tools
cd ~/Tools

# install dependencies (Ada compiler)
sudo dnf install -y fedora-gnat-project-common gprbuild gcc-gnat

# clone GHDL repo
git clone https://github.com/ghdl/ghdl.git
cd ghdl

# using mcode backend (easiest to build)
# configure 
./configure --prefix=/usr/local

# build
make

# install
sudo make install
