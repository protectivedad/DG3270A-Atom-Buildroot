#!/bin/sh

start_dir=${pwd}

img_dir=/tmp
source=${img_dir}/newsquash.img
md5=${img_dir}/newsquash.md5

eval $(cat /proc/cmdline | tr ' ' '\n' | egrep 'root=|DONT_FLASH=')

partition_0=/dev/mmcblk0p12
partition_1=/dev/mmcblk0p13

if [[ "$partition_0" == "$root" ]]; then
	dest=$partition_1
elif [[ "$partition_1" == "$root" ]]; then
	dest=$partition_0
else
	echo "Unknown boot partition, aborting."
	exit 1
fi

if [ "${DONT_FLASH}" == "y" ]; then
	echo "Debugging image booted!!!!!"
	echo "Reboot as script run to allow flashing."
	exit 1
fi

if [ ! -e "${dest}" ]; then
	echo "Destination needs to exist."
	exit 1
fi

if [ ! -f ${source} ]; then
	echo "Source image does not exist."
	exit 1
fi

if [ ! -f ${md5} ]; then
	echo "MD5 checkfile missing, aborting."
	exit 1
fi

echo "root: ${root}"

cd ${img_dir}
md5sum -s -c ${md5} 2>/dev/null
if [ $? != 0 ]; then
	echo "MD5 checksum failed, aborting."
	cd ${start_dir}
	exit 1
fi

echo "MD5 checksum passed."

echo "About to write ${source}->${dest}, proceed (y/n)"
if [[ "$1" == "-y" ]]; then
	proceed="y"
else
	read proceed
fi

if [[ "${proceed}" == "y" ]]; then
	cat ${source} >${dest}
	echo "Done."
else
	echo "!!!ABORTED!!!"
fi

