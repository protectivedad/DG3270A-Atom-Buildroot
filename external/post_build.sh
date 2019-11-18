#!/bin/sh

ROOTFS=$1

cd ${ROOTFS}

# Remove readline "old" files
rm `find usr/lib -name '*.old'`

rm_links='lib32 usr/lib32'
# Remove unneeded links.
for link in ${rm_links}; do
    [[ -L ${link} ]] && rm ${link} || true
done

rm_dirs='media/ opt/ run/'
# Remove directories that are not used.
for dir in ${rm_dirs}; do
    [[ -d ${dir} ]] && rmdir ${dir} || true
done

# Conditional links
fake_files='etc/mdc_start.sh etc/run_script etc/run_script_ct
	bin/thermal usr/sbin/hotMonitorStartScript.sh usr/sbin/hot_monitor'

for link in ${fake_files}; do
   [[ ! -e $link ]] && ln -sr etc/log_attempt.sh ${link}
done

# Remove ld config files
rm etc/ld.so.conf

# Remove modprobe files but keep modules
# rm `find lib/modules -name "modules.*"`

# Remove xfs executables only want fsck.xfs and mkfs.xfs
rm `find ./ -name "xfs_*"`

# Clearout var and tmp directories.
cd var && rm -rf . && cd ..
cd tmp && rm -rf . && cd ..

rc_deps=${ROOTFS}/etc/init.d/rc.deps
# Setup rc.deps and merge any rc.deps that exist.
[ ! -f ${rc_deps} ] && mv ${rc_deps}.base ${rc_deps} || rm ${rc_deps}.base
for dep_file in ${rc_deps}.*; do
	cat ${dep_file} >>${rc_deps}
	rm ${dep_file}
done

# These are all the used libraries or library links.
used_libs=$(find ./ -type f | xargs readelf -d 2>/dev/null | grep NEEDED | sort -u)

# Remove all library links not being used. This way
# any links left point to libraries that are required.
for lib_link in $(find -lname '*.so*' ! -name 'libnss*' ! -name 'libnl*' ! -name 'libsec*'); do
	echo ${used_libs} | fgrep -q "[$(basename ${lib_link})]"
	if [ $? != 0 ]; then
		rm ${lib_link}
	fi
done

# Remove libraries that are not in list and are not
# pointed to by a used link.
for lib in $(find -name '*.so*' -type f ! -name 'libnss*' ! -name 'libnl*' ! -name 'libsec*'); do
	# Magic check to make sure it is an ELF file.
	magic=$(hexdump -n 4 ${lib} -e '1/1 "%02x"')
	[ "${magic}" != "7f454c46" ] && continue || true
	echo ${used_libs} | fgrep -q "[$(basename ${lib})]"
	if [ $? != 0 ]; then
		lib_link=$(basename ${lib} | xargs find -lname)
		if [ "${lib_link}" == "" ]; then
			if [ "$(basename ${lib})" != "ld.so.cache" ]; then
				rm ${lib}
			fi
		fi
	fi
done

exit 0

