#!/bin/sh

echo "Waiting for router ..."
until ping -c1 192.168.1.252 >/dev/null 2>&1; do :; done

eval $(ssh dg3270a cat /proc/cmdline)

if [ "${DONT_FLASH}" == "y" ]; then
	echo "Debugging image booted!!!!!"
	echo "Reboot as script run to allow flashing."
	exit 1
fi

echo "Senging image with md5 and script."
scp ./images/newsquash.* dg3270a:/tmp

ssh dg3270a /tmp/newsquash.sh -y

if [ $? == 0 ]; then
	echo "Success."
else
	echo "Failed."
fi

