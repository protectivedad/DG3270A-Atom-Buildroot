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

BUILDROOT_VERS=2014.11

PROJ_DIR=$(pwd)
EXT_DIR=${PROJ_DIR}/external
BR_DIR=${PROJ_DIR}/buildroot
# Used in defconfig for Buildroot downloads
export DL_DIR=${PROJ_DIR}/dl

[ ! -d ${EXT_DIR} ] && \
   echo "Missing external directory." && exit 1

[ ! -d ${DL_DIR} ] && mkdir -p ${DL_DIR}
[ ! -d ${BR_DIR} ] && mkdir -p ${BR_DIR}

[ ! -d ${DL_DIR}/glibc ] && \
   git -b v${BUILDROOT_VERS} clone https://github.com/protectivedad/DG3270A-Atom-Glibc.git ${DL_DIR}/glibc

[ ! -f ${DL_DIR}/buildroot-${BUILDROOT_VERS}.tar.bz2 ] && \
   wget https://buildroot.org/downloads/buildroot-${BUILDROOT_VERS}.tar.bz2 -O ${DL_DIR}/buildroot-${BUILDROOT_VERS}.tar.bz2


tar -xf ${DL_DIR}/buildroot-${BUILDROOT_VERS}.tar.bz2 \
   -C ${BR_DIR} \
   --strip-components=1 --keep-old-files 2>/dev/null

unset PERL_MM_OPT

[ ! -f ${BR_DIR}/.config ] && \
   BR2_EXTERNAL=${EXT_DIR} make -C ${BR_DIR} dg3270a_defconfig

BR2_EXTERNAL=${EXT_DIR} make -C ${BR_DIR}
