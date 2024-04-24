#!/usr/bin/env bash

dir_scan() {
	# ver: v0.1
	local cwd=${1:-PWD} dir dirs table
	cd $cwd && {
		dirs=$(find ./ -mindepth 1 -maxdepth 1 -type d)
		for dir in ${dirs}; do dir=${dir#./}
			test -d $dir || continue
			#
			table="${table:+$table }$dir"
		done
		cd - >/dev/null
	}
	echo "$table"
}

app_check() {
	# ver: v0.1
	local app=$1
	#
	test -d $app/rootfs || {
		test -f $app/rootfs.tar.gz || return 1
	}
	#
	test -f $app/files.info || return 1

}

# usage: _app_scan <idx> <path>
_app_scan() {
	# v0.1
	local idx=$1; shift
	local dir apps dirs
	for dir in $@; do dir=${dir%/}
		app_check $dir && {
			apps=${apps:+$apps }$dir
		} || {
			_dirs=$(dir_scan $dir)
			for _dir in $_dirs; do
				dirs=${dirs:+$dirs }$dir/$_dir
			done
		}
	done
	test -n "$apps" && echo "apps:$apps"
	test -n "$dirs" && echo "dirs:$dirs"
}

app_scan() {
	# ver: v0.2
	local dirs=$@ i
	for i in $(seq 1 1 ${SCAN_DEPTH:-8}); do
		result=$(_app_scan $i $dirs)
		apps=$(echo "$result" | sed -nre 's/^apps:(.*)/\1/p')
		dirs=$(echo "$result" | sed -nre 's/^dirs:(.*)/\1/p')
		test -n "$apps" && APPS=${APPS:+$APPS }$apps
		test -n "$dirs" || break
	done
	_idx=0
	for app in $APPS; do _idx=$((_idx + 1)); printf "%2d %s\n" $_idx $app; done
}

# usage: app_install <src> <dst> [policy]
app_install() {
	# ver: 0.1
	# issues:
	# 1. files need a end null line.

	local src_rootfs=${1:-$SRC_ROOTFS}; src_rootfs=${src_rootfs:-$PWD/rootfs}
	local dst_rootfs=${2:-$DST_ROOTFS}; dst_rootfs=${dst_rootfs:-$PWD/dst_rootfs}
	local policy=${3:-$POLICY}; policy=${policy:-embed}
	local file
	#
	case $policy in
	embed) file="embed-files.installed" ;;
	devel) file="devel-files.installed" ;;
	*)     file="files.installed"
	esac

	#
	while read line; do test -n "$line" || continue
		#
		prefix=$(echo $line | cut -c 1)
		case $prefix in '#') continue;; esac
		#
		col=$(echo $line | wc -w)
		if [ ${col:-0} -eq 1 ]; then
			suffix=${line:0-1:1}; line=${line%[*/=@>]}
			case $suffix in
			'*') _type=file; _mode=755 ;;
			'/') _type=dire; _mode=755 ;;
			*)   _type=file; _mode=664
			esac
			_path=${line%/*}; if [ "${_path}" == "$line" ]; then unset _path; fi
			_file=${line##*/}
		elif [ ${col:-0} -eq 3 ]; then
			tag=$(echo $line | cut -d' ' -f2)
			case $tag in
			'->')
				_type=link; _file=$(echo $line | cut -d' ' -f1);
				_path=${_file%/*}; if [ "$_path" == "$_file" ]; then unset _path; fi
				_file=${_file##*/}; link_path=$(echo $line | cut -d' ' -f3)
				suffix=${link_path:0-1:1}; link_path=${link_path%[*/=@>]}
			;;
			esac
		else
			continue
		fi
		#
		install -m 775 -d ${dst_rootfs}${_path:+/$_path}
		case $_type in
		file) install -v -m $_mode -t ${dst_rootfs}/${_path:+$_path/} ${src_rootfs}/${_path:+$_path/}$_file ;;
		link) ln -fvs $link_path $dst_rootfs/${_path:+$_path/}$_file ;;
		dire) ;;
		*) echo $line
		esac
	done < $file
}

cmd=$1; shift
case $cmd in
install)
    app_install $1 $2 $3 ;;
scan)
    app_scan ${1:-/srv/released} ;;
*)
cat << EOF
$0 install <dst path> {full|embed|devel}
$0 scan <path>
EOF
esac