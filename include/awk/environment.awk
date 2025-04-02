
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
	if ($1 ~ /.*=/) { printf "%s", $1 } else {printf "%s=", $1 }
	if ($2 ~ /=.+/) { if (NF > 2) {
		printf "%s ", substr($2, 2, length($2))
	} else {
		printf "%s", substr($2, 2, length($2))}
	}
	for (i = 3; i <= NF; i++) {
		if (i == NF) {printf "%s", $i} else {printf "%s ", $i}
	}
	printf "\n"
}


END {
	printf "\n\n"
	printf "# Setting Terminal\n"
	printf "TOOLCHAIN_PS1_PREFIX=toolchain\n"
	printf "PS1=\"($TOOLCHAIN_PS1_PREFIX) $PS1\"\n"
}