#!/usr/bin/env bash

TOOLCHAINS_INCLUDE=$(dirname $BASH_SOURCE)
#TOOLCHAINS_HOME=$(dirname $TOOLCHAINS_INCLUDE)
TOOLCHAINS_ENVIRONMENT="${TOOLCHAINS_HOME}/environments"

export TOOLCHAINS_HOME TOOLCHAINS_INCLUDE TOOLCHAINS_ENVIRONMENT

. ${TOOLCHAINS_INCLUDE}/log.sh

# usage: env_check_toolchain <toolchain>
env_check_toolchain () {
	local toolchain=$1
	if [ ! -f "$TOOLCHAINS_ENVIRONMENT/$toolchain.environment" ]; then
		return 1
	fi
}

# usage: env_source_toolchain <toolchain>
env_source_toolchain() {
	local toolchain=${1}
	local ret

	# sed --silent \
	# 	--file="${TOOLCHAINS_INCLUDE}/sed/environment-bre.sed" \ 
	# 	"$TOOLCHAINS_ENVIRONMENT/$toolchain.environment" \
	# 	> .environment
	env_check_toolchain $toolchain; ret=$?
	if test $ret -ne 0; then
		error 1 "source $toolchain is error"
		info 1 "please select toolchain"
		env_list_toolchain
		return
	fi 

	sed --silent --regexp-extended \
	 	--file="${TOOLCHAINS_INCLUDE}/sed/environment-ere.sed" \
		"$TOOLCHAINS_ENVIRONMENT/$toolchain.environment" \
		> .environment
	
	source .environment
}

# usage: env_list_toolchain
env_list_toolchain() {
	echo -e "List toolchains:\n"
	for each in $(ls ${TOOLCHAINS_ENVIRONMENT}/*.environment 2>/dev/null); do
		each=$(basename $each)
		echo -e "\t${each%.environment}\n"
	done
}








