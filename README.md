# crossbuild-ssl-rust
For creating, maintaining docker images based on crossbuild, adding OpenSSL and
the Rust toolchain.

One image that supports building for Windows, Mac OS and Linux targets.
/usr/local contains builds of OpenSSL against which Rust sources can be linked.
NOTE: The Windows image links dynamically while the other two link statically.
This means resulting Windows binaries will need the OpenSSL DLL to be installed
as well.

The base image is based on a fork of multiarch/crossbuild where the Mac OS
tools are more up to date.

The image contains the Rust tool chain, some additional rooling (clippy,
cargo-outdated, cargo-audit) and the respective cross compile targets for Mac
and Windows.

To update/publish:

```bash
$ make
```

Update `rust_ver` in `Makefile` for new releases of Rust. Update the build
scripts for OpenSSL to pick up newer versions.

To use:

```bash
$ docker run -v"$(pwd)"/workdir --rm -it cmdln/crossbuild-ssl-rust lin-cargo build
$ docker run -v"$(pwd)"/workdir --rm -it cmdln/crossbuild-ssl-rust mac-cargo build
$ docker run -v"$(pwd)"/workdir --rm -it cmdln/crossbuild-ssl-rust win-cargo build
```

The scripts (`lin-cargo`, `mac-cargo`, `win-cargo`) set the environment for the
given target, including the necessary variables to use the associated OpenSSL
build. Do not use these scripts to run `cargo outdated` and `cargo audit`;
those should work as is.

## Known issues

Resulting binaries are owned by root. Should be possible to use USER in the
docker files to map the user in the container to something more reasonable.
