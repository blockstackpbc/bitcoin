#!/bin/sh -x

cd /srv/
echo ""
echo "Installing Required libraries"
echo ""
apt-get update \
&& apt-get install -y \
  autoconf \
  build-essential \
  libtool \
  pkg-config \
  python3 \
  libboost-dev \
  libboost-system-dev \
  libboost-filesystem-dev \
  libboost-thread-dev \
  libssl-dev \
  libevent-dev \
  git \
  libczmq-dev
/sbin/ldconfig /usr/lib /lib
echo ""
echo "Running autogen"
echo ""
sh autogen.sh
echo ""
echo "Configuring bitcoin"
echo ""
./configure \
  --enable-util-cli \
  --disable-gui-tests \
  --disable-wallet \
  --enable-static \
  --disable-tests \
  --without-miniupnpc \
  --disable-shared \
  --with-pic \
  --enable-cxx \
  LDFLAGS="-static-libstdc++" \
  CXXFLAGS="-static-libstdc++"
echo ""
echo "Compiling bitcoin"
echo ""
make STATIC=1
echo ""
echo "Creating Binary dist"
echo ""
sh -x make_binary_dist.sh
echo ""
echo "Cleaning up"
echo ""
make distclean
