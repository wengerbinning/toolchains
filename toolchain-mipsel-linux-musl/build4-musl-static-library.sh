#!/bin/bash

ARCH=mips
TARGET="mipsel-unknown-linux-musl"
CROSS_COMPILE="mipsel-unknown-linux-musl-"
TOOLCHAIN_PATH="/opt/toolchains/toolchain-mipsel-linux-musl"
export PATH="$TOOLCHAIN_PATH/bin${PATH:+:$PATH}"

# Musl Stage 1
test -d "${workdir:-build-stage1}" || mkdir -p "${workdir:-build-stage1}"
src=$PWD && cd "${workdir:-build-stage1}" && {
	$src/configure --prefix= --target=$TARGET CROSS_COMPILE=$CROSS_COMPILE \
        --disable-shared || exit
	make -j$(nproc) || exit
	make install DESTDIR=$src/dst-stage1 || exit
	echo -e "\e[32mBuild $src finished.\e[0m"
cd - >/dev/null; }
