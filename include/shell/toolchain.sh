


TOOLCHAIN_DIRTREES=(
    sbin
	bin
    include
    lib
	#
	usr/{sbin,bin,include,lib,share}
    etc/{}
	var
	# aarch64-openwrt-linux-musl
    build/{released,rootfs}
    host/{released,rootfs}
    target/{released,rootfs}
)


toolchain_prepare_dirtrees() {
	mkdir -p ${TOOLCHAIN_DIRTREES[@]} 
}

toolchain_clean_dirtrees() {
	rm -rf ${TOOLCHAIN_DIRTREES[@]}	
}

toolchain_create_softlink() {
	local file_prefix=$1
	local link_prefix=$2
	shift 2

	echo creat softlink form $file_prefix to $link_prefix
	
	for file in "$@"; do
		ln -s $file ${link_prefix}${file#$file_prefix}
	done

}





main() {
	case $1 in
	clean)
		toolchain_clean_dirtrees
		;;
	*)
		eval $@
		;;
	esac
}

main "$@"
