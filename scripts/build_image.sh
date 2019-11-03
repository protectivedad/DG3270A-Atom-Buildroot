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

PROJ_DIR=$(pwd)

. ${PROJ_DIR}/definitions

make prep && make -C ${BR_DIR}
