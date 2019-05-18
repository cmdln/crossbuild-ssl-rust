rustver = 1.34.2
ssl = 1.1.1b
# 1.1.x doesn't cross-compile for Windows
winssl = 1.0.2r

all: mac linux win

mac:
	docker build --no-cache -t cmdln/crossbuild-ssl-rust-mac:$(ssl)-$(rustver) \
		--build-arg RUST_VER=$(rustver) \
		--build-arg OPENSSL_VER=$(ssl) \
		-f Dockerfile.mac .
	docker push cmdln/crossbuild-ssl-rust-mac:$(ssl)-$(rustver)

linux:
	docker build -t cmdln/crossbuild-ssl-rust-linux:$(ssl)-$(rustver) \
		--build-arg RUST_VER=$(rustver) \
		--build-arg OPENSSL_VER=$(ssl) \
		-f Dockerfile.linux .
	docker push cmdln/crossbuild-ssl-rust-linux:$(ssl)-$(rustver)

win:
	docker build -t cmdln/crossbuild-ssl-rust-win:$(winssl)-$(rustver) \
		--build-arg RUST_VER=$(rustver) \
		--build-arg OPENSSL_VER=$(winssl) \
		-f Dockerfile.win .
	docker push cmdln/crossbuild-ssl-rust-win:$(winssl)-$(rustver)
