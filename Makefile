all: mac linux win

mac:
	docker build -t cmdln/crossbuild-ssl-rust-mac -f Dockerfile.mac .
	docker push cmdln/crossbuild-ssl-rust-mac

linux:
	docker build -t cmdln/crossbuild-ssl-rust-linux -f Dockerfile.linux .
	docker push cmdln/crossbuild-ssl-rust-linux

win:
	docker build -t cmdln/crossbuild-ssl-rust-win -f Dockerfile.win .
	docker push cmdln/crossbuild-ssl-rust-win
