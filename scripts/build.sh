#!/bin/sh

# Expects the current project directory:
#   proj_dir/
#       scripts/    - Script directory
#       external/   - Buildroot external directory
#
# Creates:
#   proj_dir/
#       buildroot/  - Source and build directory
#       dl/         - Download directory
#

if [[ "$1" == "" ]]; then
	echo "Needed stage to build either toolchain, nonlto, or lto."
	exit 1
fi

export PROJ_DIR=$(pwd)

. ${PROJ_DIR}/definitions

make -C ${BR_DIR} && touch .$1 || exit 1

