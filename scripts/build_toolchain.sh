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

export DG3270A_PROJ_DIR=$(pwd)

. ${DG3270A_PROJ_DIR}/definitions

make toolchain

make -C ${BR_DIR} && touch .toolchain || exit 1

