
BEGIN {}

# Comments - Nothing to do
/^\s*#*/ {}

#
/^\s*##/ {
	if (NR == 1) {printf "# "} else {printf "\n# "}
	for (i = 2; i <= NF; i++) { if ( i == NF ) {printf "%s", $i} else {printf "%s ", $i} }
	printf "\n"
}

# import
/^\s*import/ {
	for (i = 2; i <= NF; i++) {
		printf "import %s\n", $i
	}
}

# export
/^\s*export/ {
	printf "%s\n", $0
}

# default
/^\s*[^(#*|import|export)]/ {
	printf "%s=", $1
	for (i = 3; i <= NF; i++) { if ( i == NF ) {printf "%s", $i} else {printf "%s ", $i} }
	printf "\n"
}


END {
	printf "\n\n"
	printf "# Setting Terminal\n"
	printf "TOOLCHAIN_PS1_PREFIX=toolchain\n"
	printf "PS1=\"($TOOLCHAIN_PS1_PREFIX) $PS1\"\n"
}