
BEGIN {}

# Comments - Nothing to do
/^\s*#*/ {}

#
/^\s*##/ {
    if (NR == 1)
        printf "%s\n", $0
    else
        printf "\n%s\n", $0

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
    printf "%s=%s\n", $1, $3
}


END {
    printf "\n\n"
    printf "# Setting Terminal\n"
    printf "TOOLCHAIN_PS1_PREFIX=toolchain\n"
    printf "PS1=\"($TOOLCHAIN_PS1_PREFIX) $PS1\"\n"
}