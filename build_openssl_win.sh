#!/usr/bin/env bash

# This script is intended to be run within a container based on the
# cmdln/crossbuild image with the working directory mounted into the container;
# see the start_crossbuild.sh script which is responsible for setting up such a
# container

ssl_ver="${1:-1.0.2r}"

OLD_LD_LIB_PATH="${LD_LIBRARY_PATH}"
export OPENSSL_DIR="/usr/local/win"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$OPENSSL_DIR/lib"
export PKG_CONFIG_ALLOW_CROSS="1"
export MINGW="${MINGW:-x86_64-w64-mingw32}"

curl -O "https://www.openssl.org/source/openssl-${ssl_ver}.tar.gz"
tar xf "openssl-${ssl_ver}.tar.gz"
cd "openssl-${ssl_ver}" || exit 1
./Configure mingw64 shared --prefix=/usr/local/win --cross-compile-prefix=/usr/x86_64-w64-mingw32/bin/ || exit 2

make || exit 3
make install || exit 4
cp ./*eay* /usr/local/win/lib
cd .. || exit 5
rm -rf openssl*
unset OPENSSL_DIR OPENSSL_STATIC PKG_CONFIG_ALLOW_CROSS
export LD_LIBRARY_PATH="${OLD_LD_LIB_PATH}"
