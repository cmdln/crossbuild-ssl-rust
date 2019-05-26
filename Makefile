rustver = 1.35.0

all:
	docker build --no-cache -t cmdln/crossbuild-ssl-rust:$(rustver) \
		-t cmdln/crossbuild-ssl-rust:latest \
		--build-arg RUST_VER=$(rustver) \
		.
	#docker push cmdln/crossbuild-ssl-rust:$(rustver)
	#docker push cmdln/crossbuild-ssl-rust:latest
