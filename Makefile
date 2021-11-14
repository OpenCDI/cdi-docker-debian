DOCKERIAN = ${DOCKERIAN:-docker}
BUILD = build_image
PUSH = push_image
LOAD = .
CI = ${PWD}/ci_functions.sh

all:
	sh -exc "${LOAD} ${CI}; build_all"
core:
	sh -exc "${LOAD} ${CI}; build_core"
firefox:
	sh -exc "${LOAD} ${CI}; build_core; build_image Debian-Base/Firefox_*"
