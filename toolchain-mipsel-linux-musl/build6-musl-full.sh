#!/bin/bash

ARCH=mips
TARGET="mipsel-unknown-linux-musl"
CROSS_COMPILE="mipsel-unknown-linux-musl-"
TOOLCHAIN_PATH="/opt/toolchains/toolchain-mipsel-linux-musl"
export PATH="$TOOLCHAIN_PATH/bin${PATH:+:$PATH}"

# Stage 2
test -d "${workdir:-build-stage2}" || mkdir -p "${workdir:-build-stage2}"
src=$PWD && cd "${workdir:-build-stage2}" && {
	$src/configure --prefix= --target=$TARGET CROSS_COMPILE=$CROSS_COMPILE || exit
	make -j$(nproc) || exit
	make install DESTDIR=$src/dst-stage2 || exit
	echo -e "\e[32mBuild $src finished.\e[0m"
cd - >/dev/null; }
