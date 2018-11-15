# crossbuild-ssl-rust
For creating, maintaining docker images based on crossbuild, adding OpenSSL and
the Rust toolchain.

One image each for Windows, Mac OS and Linux. Each image contains a build of
OpenSSL against which Rust sources can be linked. NOTE: The Windows image links
dynamically while the other two link statically. This means resulting Windows
binaries will need the OpenSSL DLL to be installed as well.

The base image is based on a fork of multiarch/crossbuild where the Mac OS
tools are more up to date.

Each image contains the Rust tool chain and for Mac and Windows the
respective cross compile target.

Each image has clippy-preview and cargo-outdated installed.

To update/publish:

```bash
$ docker build -f Dockerfile.mac -t cmdln/crossbuild-ssl-rust-mac .
$ docker push cmdln/crossbuild-ssl-rust-mac
```

To use:

```bash
$ docker run -v"$(pwd)"/workdir --rm -it cmdln/crossbuild-ssl-rust-mac
```

## Known issues

Resulting binaries are owned by root. Should be possible to use USER in the
docker files to map the user in the container to something more reasonable.
