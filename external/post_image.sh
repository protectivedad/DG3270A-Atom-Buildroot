#!/bin/sh

IMAGEFS=$1

cd ${DG3270A_PROJ_DIR}/images/

cp ${IMAGEFS}/rootfs.squashfs newsquash.img
md5sum newsquash.img >newsquash.md5


