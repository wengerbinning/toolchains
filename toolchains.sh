#!/usr/bin/env bash

##
SCRIPT_HOME=$(cd $(dirname $BASH_SOURCE) && pwd);

## Default Variable
DEFAULT_TOOLCHAINS_HOME=${SCRIPT_HOME}

##
TOOLCHAIN_HOME="/mnt/work/toolchains"

## Check Variuable
TOOLCHAINS_HOME=${TOOLCHAINS_HOME:-$DEFAULT_TOOLCHAINS_HOME}
TOOLCHAINS_INCLUDE=${TOOLCHAINS_HOME}/include

##
source ${TOOLCHAINS_INCLUDE}/environment.sh


##
case $1 in
dump)
    env_scan_toolchain ;;
import)
    env_import_toolchain $2;;
*)
    env_scan_toolchain
esac
