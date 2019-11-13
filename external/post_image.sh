#!/bin/sh

IMAGEFS=$1

cd ${PROJ_DIR}/images/

cp ${IMAGEFS}/rootfs.squashfs newsquash.img
md5sum newsquash.img >newsquash.md5


