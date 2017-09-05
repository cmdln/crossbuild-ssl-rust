#!/usr/bin/env bash

# This script is intended to be run within a container based on the
# cmdln/crossbuild image with the working directory mounted into the container;
# see the start_crossbuild.sh script which is responsible for setting up such a
# container

os="${1:-linux}"

case "${os}" in
    linux)
        openssl_vers="1.1.0f"
        target="linux-x86_64"
        config_options=()
        ;;
    mac)
        openssl_vers="1.1.0f"
        target="darwin64-x86_64-cc"
        config_options=(--cross-compile-prefix=/usr/x86_64-apple-darwin15/bin/ -fPIC)
        ;;
    win)
        openssl_vers="1.0.2l"
        target="mingw64"
        config_options=(shared --cross-compile-prefix=/usr/x86_64-w64-mingw32/bin/)
        export MINGW="${MINGW:-x86_64-w64-mingw32}"
        ;;
    *)
        echo "Unsupported OS: ${os}" && exit 1 ;;
esac

curl -O "https://www.openssl.org/source/openssl-${openssl_vers}.tar.gz"
tar xf "openssl-${openssl_vers}.tar.gz"
cd "openssl-${openssl_vers}" || exit 1
./Configure ${target} "${config_options[@]}" || exit 2

make || exit 3
make install || exit 4
if [ "${os}" == "win" ]
then
    cp ./*eay* /usr/local/ssl/lib
fi
cd .. || exit 5
rm -rf openssl*
