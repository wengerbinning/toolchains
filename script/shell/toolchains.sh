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

source ${TOOLCHAINS_INCLUDE}/environment.sh

toolchains_cmd_list() {
	env_list_toolchain
}





toolchains_cmd_source() {
	env_source_toolchain "$@"
}


cmd_main() {
	cmd=$1; shift
	case $cmd in
	list)
		toolchains_cmd_list
		;;
	source)
		echo "source $TOOLCHAINS_BIN/toolchains $1"
		;;
	configure)
		echo "developing"
		;;
	build)
		echo "developing"
		;;
	*)
		echo "${BASH_SOURCE[0]} {list|configure}|build}"
	esac
}



case $0 in
*bash)
	if [ -z "$1" ]; then
		cmd_main list
	fi

	env_source_toolchain $1
	;;
*zsh)
	;;
*)
	cmd_main "$@"
esac





