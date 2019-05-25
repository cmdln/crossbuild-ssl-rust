#!/usr/bin/env bash

# This script is intended to be run within a container based on the
# cmdln/crossbuild image with the working directory mounted into the container;
# see the start_crossbuild.sh script which is responsible for setting up such a
# container

ssl_ver="${1:-1.1.1b}"

OLD_LD_LIB_PATH="${LD_LIBRARY_PATH}"
export OPENSSL_DIR="/usr/local/mac"
export OPENSSL_STATIC="1"
export LD_LIBRARY_PATH="/usr/x86_64-linux-gnu/x86_64-apple-darwin15/lib"
PATH="/usr/x86_64-apple-darwin15/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# activate cross compilation
export PKG_CONFIG_ALLOW_CROSS="1"

curl -O "https://www.openssl.org/source/openssl-${ssl_ver}.tar.gz"
tar xf "openssl-${ssl_ver}.tar.gz"
cd "openssl-${ssl_ver}" || exit 1
./Configure darwin64-x86_64-cc --prefix=/usr/local/mac --cross-compile-prefix=/usr/x86_64-apple-darwin15/bin/ -fPIC || exit 2

make || exit 3
make install || exit 4
rm -rf openssl*
unset OPENSSL_DIR OPENSSL_STATIC PKG_CONFIG_ALLOW_CROSS
export LD_LIBRARY_PATH="${OLD_LD_LIB_PATH}"
