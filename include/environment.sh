#!/usr/bin/env bash

SCRIPT_HOME=$(cd $(dirname $BASH_SOURCE) && pwd);

TOOLCHAINS_HOME=${TOOLCHAINS_HOME:-$(dirname $SCRIPT_HOME)}
TOOLCHAINS_BIN=${TOOLCHAINS_HOME}/bin
TOOLCHAINS_INCLUDE=${TOOLCHAINS_HOME}/include

DEFAULT_TOOLCHAIN_HOME=${TOOLCHAINS_HOME}

# =========================================================================== #

error()   { return; }
warning() { return; }
info()    { return; }
debug()   { return; }
notice()  { return; }

# --------------------------------------------------------------------------- #

_env_prepare () {
cat > ${1:-.environment} << EOF
# Detect multiple imported environments
test -n "\$TOOLCHAIN_PATH" && { echo -e "\e[33mYou have imported '\$TOOLCHAIN_NAME'!\e[0m"; return; }
# =========================================================================== #
EOF
}

# --------------------------------------------------------------------------- #

# usage: env_scan_toolchain [path]
env_scan_toolchain () {
	local path
	TOOLCHAIN_HOME=${TOOLCHAIN_HOME:-$DEFAULT_TOOLCHAIN_HOME}
	path=${1:-$TOOLCHAIN_HOME}
	for dir in $(find ${path:-$TOOLCHAINS_HOME} -mindepth 1 -maxdepth 1 -type d | xargs); do
		test -f "$dir/environment" && echo $(basename $dir)
	done
}

# usage: env_check_toolchain <toolchain>
env_check_toolchain () {
	local toolchain=$1
	test -f "$toolchain/environment" || return 1
}

# usage: env_import_toolchain <toolchain>
env_import_toolchain() {
	local toolchain=${1}

	TOOLCHAIN_HOME=${TOOLCHAIN_HOME:-$DEFAULT_TOOLCHAIN_HOME}
	toolchain=${TOOLCHAIN_HOME:+$TOOLCHAIN_HOME/}$toolchain
	TOOLCHAIN_NAME=$(basename $toolchain)

	#
	_env_prepare .environment
	awk -f ${TOOLCHAINS_INCLUDE}/awk/environment.awk $toolchain/environment >> .environment
	# Hangdling imported variables
	for var in $(awk -e '/^import.*/ {print $2}' .environment | xargs); do
		eval val=\$${var}
		test -n "$val" || warning ""
		sed -i "s|^import $var|$var=$val|g" .environment
	done

	source .environment
}

# =========================================================================== #
