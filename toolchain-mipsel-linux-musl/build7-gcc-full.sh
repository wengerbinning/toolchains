#!/bin/bash


ARCH=mips
TARGET="mipsel-unknown-linux-musl"
TOOLCHAIN_PATH="/opt/toolchains/toolchain-mipsel-linux-musl"
export PATH="$TOOLCHAIN_PATH/bin${PATH:+:$PATH}"

# $TARGET-gcc -E -Wp,-v -xc /dev/null
# exit
# Stage 3
test -d "${workdir:-build-stage2}" || mkdir -p "${workdir:-build-stage2}"
src=$PWD && cd "${workdir:-build-stage2}" && {
	$src/configure ARCH=$ARCH --target=$TARGET \
		--prefix= \
		--enable-languages=c,c++ \
		--with-sysroot=/ --with-build-sysroot=$TOOLCHAIN_PATH || exit
	make -j$(nproc) || exit
	make install DESTDIR=$src/dst-stage3 || exit
	echo -e "\e[32mBuild $src finished.\e[0m"
cd - >/dev/null; }
