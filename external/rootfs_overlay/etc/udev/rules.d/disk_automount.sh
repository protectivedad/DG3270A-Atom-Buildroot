#!/bin/sh
#
#GPL LICENSE SUMMARY
#
# Copyright(c) 2005-2012 Intel Corporation. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of version 2 of the GNU General Public License as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
# The full GNU General Public License is included in this distribution
# in the file called LICENSE.GPL.
#
# Contact Information
# Intel Corporation
# 2200 Mission College Blvd.
# Santa Clara, CA 97052
#


# Simple hotplug script that mounts removable USB sticks.

# Uncomment the following line to turn on debugging.
# DEBUG=yes; export DEBUG

source /etc/profile

MOUNTPOINT=/tmp/mnt/disk
LOCKDIR=/tmp/lock
LOCKFILE=/tmp/lock/disk

# If the lock directory does not exist, creat it.
if [ ! -e $LOCKDIR ]; then
	mkdir $LOCKDIR
fi


if [ -x /usr/bin/logger ]; then
    LOGGER=/usr/bin/logger
elif [ -x /bin/logger ]; then
    LOGGER=/bin/logger
fi


# Function: mesg
mesg () {
	$LOGGER -t $(basename $0)"[$$]" "$@"
}


# Function: debug_mesg
debug_mesg () {
    test "$DEBUG" = "" -o "$DEBUG" = no && return
    mesg "SEQNUM:$SEQNUM $@"
}

debug_mesg "arguments ($*) env (`env`)"


REMOVABLE="/sys$DEVPATH/removable"

if [ "$ACTION" == "add" ] ; then
	# If we have $REMOVABLE then we are not mountable partition.  TODO: This is not a robust check.
	if [ `cat $REMOVABLE` -eq 0 ] ; then
		debug_mesg "The flag in the file $REMOVABLE is 0.  It is most likely not a mountable partition.  Exiting."
		exit 1
	else
		debug_mesg "The flag in the file $REMOVABLE is 1.  It is most likely a mountable partition."
	fi

	DEVICENAME=`basename $DEVPATH`
	debug_mesg "Mounting device: $DEVICENAME.."
	
	count=$(echo $DEVICENAME | grep -o ..$)
	
	for var in `blkid /dev/$DEVICENAME | cut -d ":" -f 2`; do eval ${var}; done

	if test -n "${UUID}" ;then
		MOUNTPOINT=/tmp/mnt/$UUID
	else
		MOUNTPOINT=/tmp/mnt/disk$count
	fi
	num = $(echo $DEVICENAME | grep -o .$)
	if [ $num -gt 8 ] ; then
		debug_mesg "Error: Exceeded number of supported mount points.  Exiting."
		exit 1;
	fi
        # Attempt to find a suitable mount point for newly hotplugged device/partition.
	# If the mount point does not exist then create it.
    if [ ! -e ${MOUNTPOINT} ]; then
		# Create it
               	/bin/mkdir -p ${MOUNTPOINT}
		# if the lock file does not exist then create it and exit the while loop.
		touch ${LOCKFILE}$count;
		if [ ! -e ${LOCKDIR}/$DEVICENAME ]; then
			echo "${MOUNTPOINT}" > ${LOCKDIR}/$DEVICENAME
		fi
               	debug_mesg "Executed: /bin/mkdir/ -p ${MOUNTPOINT} for $DEVICENAME"
	# If the mount point does exist then make sure we can use it
	else
		# Check if the mount point is actually mounted
		MOUNT=`grep "${MOUNTPOINT} " /proc/mounts |cut -d " " -f 2`
		debug_mesg "MOUNT1 = $MOUNT.  Trying to mount $DEVICENAME at: ${MOUNTPOINT}."
		if [ "$MOUNT" -eq "" ] ; then
			# if the lock file does not exist then create it and exit the while loop.
			if [ ! -e ${LOCKFILE}$count ]; then
				touch ${LOCKFILE}$count;
				debug_mesg "Mount point (${MOUNTPOINT}$count) already existed but not used.  Will use it instead of creating a new one, for: $DEVICENAME."
				if [ ! -e ${LOCKDIR}/$DEVICENAME ]; then
					# Put in our LOCKPID before the competing script does it.
					echo "${MOUNTPOINT}$count" > ${LOCKDIR}/$DEVICENAME
				fi
			fi
		fi
	fi


	debug_mesg "Executing: /bin/mount -o noatime /dev/$DEVICENAME ${MOUNTPOINT}"
#	/bin/mount -o noatime,ro /dev/$DEVICENAME ${MOUNTPOINT}
	/bin/mount /dev/$DEVICENAME ${MOUNTPOINT}
	debug_mesg "Done mounting device: $DEVICENAME to ${MOUNTPOINT}$count."

	MOUNT=`grep "${MOUNTPOINT} " /proc/mounts |cut -d " " -f 2`
	# The mount command for ntfs is different. So if /bin/mount failed, try ntfs-3g again.
	if [ "$MOUNT" -eq "" ] ; then
		debug_mesg "If /bin/mount does not work, try ntfs-3g in case the device has NTFS file system. Executing: ntfs-3g -o noatime /dev/$DEVICENAME ${MOUNTPOINT}"
		ntfs-3g /dev/$DEVICENAME ${MOUNTPOINT}
		debug_mesg "Done mounting device: $DEVICENAME to ${MOUNTPOINT}."
	fi
	# If mount was unsuccessful then remove mount point.
	MOUNT=`grep "${MOUNTPOINT} " /proc/mounts |cut -d " " -f 2`
	if [ "$MOUNT" -eq "" ] ; then
		debug_mesg "Last mount for /dev/$DEVICENAME attempt unsuccesful.  Removing mount point: ${MOUNTPOINT}."
		/bin/rmdir ${MOUNTPOINT}
		# Also remove the lockfile
		rm -rf ${LOCKFILE}$count
	fi
elif [ "$ACTION" == "remove" ] ; then

	DEVICENAME=`basename $DEVPATH`
	MOUNT=`grep "/dev/$DEVICENAME " /proc/mounts |cut -d " " -f 2`
	if [ "$MOUNT" -eq "" ] ; then

		debug_mesg "Device: /dev/$DEVICENAME of DEVPATH:$DEVPATH does not appear to be currently mounted.  No umount attempted."

		# Guess the name of the stale mount point so that we can attempt to clean up locks and mount points.
		MOUNT=`cat ${LOCKDIR}/$DEVICENAME`
		# If we dont have a mount point at all at this point then we must give up.
		if [ "$MOUNT" -eq "" ] ; then
			exit 1;
		fi
	else 
		debug_mesg "Unmounting device: /dev/$DEVICENAME of DEVPATH:$DEVPATH from $MOUNT"
		/bin/umount -l $MOUNT
	fi

	# Remove mount point.
	/bin/rmdir $MOUNT

	# Remove the lock files.
	MOUNTNAME=`basename $MOUNT`;
	rm -rf $LOCKDIR/$MOUNTNAME;
	rm -rf $LOCKDIR/$DEVICENAME;
else
    debug_mesg hotplug $ACTION event not supported
    exit 1
fi
