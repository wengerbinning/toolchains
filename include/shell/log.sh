error() {
	local level=$1; shift
	echo "[ERROR] $@"
}

warnning() {
	local level=$1; shift
	echo "[WARNNING] $@"
}

notice() {
	local level=$1; shift
	echo "[NOTICE] $@"
}

info() {
	local level=$1; shift
	echo "[INFO] $@"
}

debug() {
	local level=$1; shift
	echo "[DEBUG] $@"
}
