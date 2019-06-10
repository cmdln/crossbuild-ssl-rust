FROM cmdln/crossbuild

ARG RUST_VER=1.35.0
ARG OPENSSL_VER=1.1.1c
ARG WIN_OPENSSL_VER=1.0.2s

#RUN apt update && \
#        apt upgrade -y

ADD build_openssl.sh .
ADD build_openssl_mac.sh .
ADD build_openssl_win.sh .

RUN ./build_openssl.sh $OPENSSL_VER
RUN ./build_openssl_mac.sh $OPENSSL_VER
RUN ./build_openssl_win.sh $WIN_OPENSSL_VER

ENV PATH "/root/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV OPENSSL_DIR "/usr/local"
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib

RUN curl https://sh.rustup.rs -sSf -o rustup.sh && \
        sh ./rustup.sh -y && \
        rustup default $RUST_VER && \
        rustup target add x86_64-apple-darwin && \
        rustup target add x86_64-pc-windows-gnu && \
        rm rustup.sh

RUN rustup component add clippy
RUN cargo install cargo-outdated
RUN cargo install cargo-audit

ADD mac-cc /usr/local/bin/
ADD mac-c++ /usr/local/bin/
ADD mac-cargo /usr/local/bin/
ADD lin-cargo /usr/local/bin/
ADD win-cargo /usr/local/bin/


CMD ["lin-cargo", "build", "--release"]
