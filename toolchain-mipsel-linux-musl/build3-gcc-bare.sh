#!/bin/bash

ARCH=mips
TARGET="mipsel-unknown-linux-musl"

TOOLCHAIN_PATH="/opt/toolchains/toolchain-mipsel-linux-musl"
export PATH="$TOOLCHAIN_PATH/bin${PATH:+:$PATH}"


test -d "${workdir:-build-stage1}" || mkdir -p "${workdir:-build-stage1}"
src=$PWD && cd "${workdir:-build-stage1}" && {
    	$src/configure ARCH=$ARCH --target=$TARGET \
		--prefix= \
		--enable-languages=c \
		--without-headers \
		--disable-shared \
		--with-sysroot=/ --with-build-sysroot=$TOOLCHAIN_PATH || exit
	make -j$(nproc) all-gcc || exit
	make install-gcc DESTDIR=$src/dst-stage1 || exit
	echo -e "\e[32mBuild $src finished.\e[0m"
cd - >/dev/null; }
