#!/bin/bash

ARCH=mips
TARGET="mipsel-unknown-linux-musl"

TOOLCHAIN_PATH="/opt/toolchains/toolchain-mipsel-linux-musl"
export PATH="$TOOLCHAIN_PATH/bin${PATH:+:$PATH}"


# Stage 2
test -d "${workdir:-build-stage1}" || mkdir -p "${workdir:-build-stage1}"
src=$PWD && cd "${workdir:-build-stage1}" && {
	make -j$(nproc) all-target-libgcc || exit
	make install-target-libgcc DESTDIR=$src/dst-stage2 || exit
	echo -e "\e[32mBuild $src finished.\e[0m"
cd - >/dev/null; }
