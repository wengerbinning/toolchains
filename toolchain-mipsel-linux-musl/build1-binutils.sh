#!/bin/bash

TARGET="mips-unknown-linux-musl"

ARCH=mips
TARGET="mipsel-unknown-linux-musl"
TOOLCHAIN_PATH="/opt/toolchains/toolchain-mipsel-linux-musl"

test -d "${workdir:-build}" || mkdir -p "${workdir:-build}"
src=$PWD && cd "${workdir:-build}" && {
	$src/configure --prefix= --target=$TARGET --with-sysroot=/ || exit
	make -j$(nproc) || exit
	make install DESTDIR=$src/dst || exit
	echo -e "\e[32mBuild $src finished.\e[0m"
cd - >/dev/null; }
