#!/bin/sh
which sudo || alias sudo=eval
install_linux() {
  sudo apt-get -y update
  sudo apt-get -y install gforth gforth-lib libffi-dev libltdl7 libsoil-dev libtool make gcc automake texinfo texi2html texlive install-info dpkg-dev debhelper yodl bison libpcre3-dev libboost-dev git g++ # yodl, bison, ... git: are for swig
  sudo apt-get -y install libtool-bin
  sudo apt-get -y install autoconf-archive
  sudo apt-get -y install libx11-dev
  sudo apt-get -y install libgles2-mesa-dev
  sudo apt-get -y install libgl1-mesa-dev
  sudo apt-get -y install libwayland-dev
  sudo apt-get -y install libharfbuzz-dev
  sudo apt-get -y install libvulkan-dev
  sudo apt-get -y install libpng-dev
  sudo apt-get -y install libfreetype6-dev
  sudo apt-get -y install libgstreamer1.0-dev
  sudo apt-get -y install libgstreamer-plugins-base1.0-dev
  if [ `uname -m`$M32 = x86_64-m32 ]; then
    sudo apt-get -y --fix-missing install gcc-multilib libltdl7:i386
  fi
}

install_osx() {
  brew tap forthy42/homebrew-zsh
  brew update > /dev/null
  brew upgrade > /dev/null
  brew install yodl gforth gcc harfbuzz texinfo xz
  export PATH="/usr/local/opt/texinfo/bin:$PATH"
  brew cask install xquartz mactex
  export PATH="/Library/TeX/texbin:$PATH"
  brew link --overwrite gcc
  (cd /usr/local/Cellar/gcc/8.2.0/lib/gcc/8/gcc/x86_64-apple-darwin17.7.0/8.2.0/include-fixed; mv stdio.h stdio.h.botched)
}

install_${TRAVIS_OS_NAME:-linux}
./install-swig.sh
./install-freetype-gl.sh
