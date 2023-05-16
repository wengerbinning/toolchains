#!/usr/bin/env bash

#
# usage: toolchains_get_default_home ${BASH_SOURCE[0]}
#
toolchains_get_default_home() {
    local path abs_path
    path=$(dirname ${BASH_SOURCE[0]})
    abs_path=$(cd $path && pwd)
    dirname $abs_path
}

TOOLCHAINS_DEFAULT_HOME=$(toolchains_get_default_home ${BASH_SOURCE[0]})
TOOLCHAINS_HOME=${TOOLCHAINS_HOME:-$TOOLCHAINS_DEFAULT_HOME}
TOOLCHAINS_INCLUDE="${TOOLCHAINS_HOME}/include"
TOOLCHAINS_LIB="${TOOLCHAINS_HOME}/lib"
TOOLCHAINS_LIBEXEC="${TOOLCHAINS_HOME}/libexec"
TOOLCHAINS_BIN="${TOOLCHAINS_HOME}/bin"

append_path () {
	case ":$PATH:" in
	*:"$1":*)
		;;
	*)
		PATH="${PATH:+$PATH:}$1"
	esac
}

append_path "${TOOLCHAINS_BIN}"

unset append_path toolchains_get_default_home
unset TOOLCHAINS_DEFAULT_HOME TOOLCHAINS_HOME
unset TOOLCHAINS_INCLUDE TOOLCHAINS_LIB
unset TOOLCHAINS_LIBEXEC TOOLCHAINS_BIN

