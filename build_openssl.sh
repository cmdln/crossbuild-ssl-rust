#!/usr/bin/env bash

# This script is intended to be run within a container based on the
# cmdln/crossbuild image with the working directory mounted into the container;
# see the start_crossbuild.sh script which is responsible for setting up such a
# container

ssl_ver="${1:-1.1.1b}"

export OPENSSL_STATIC="1"

curl -O "https://www.openssl.org/source/openssl-${ssl_ver}.tar.gz"
tar xf "openssl-${ssl_ver}.tar.gz"
cd "openssl-${ssl_ver}" || exit 1
./Configure linux-x86_64 || exit 2

make || exit 3
make install || exit 4

cd .. || exit 5
rm -rf openssl*

unset OPENSSL_STATIC
