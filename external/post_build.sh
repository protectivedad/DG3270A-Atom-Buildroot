#!/bin/sh

ROOTFS=$1

cd ${ROOTFS}

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
rm `find lib/modules -name "modules.*"`

# Remove xfs executables only want fsck.xfs and mkfs.xfs
rm `find ./ -name "xfs_*"`

# Clearout var and tmp directories.
cd var && rm -rf . && cd ..
cd tmp && rm -rf . && cd ..

rc_deps=${ROOTFS}/etc/init.d/rc.deps
# Setup rc.deps and merge any rc.deps that exist.
if [ ! -f ${rc_deps} ]; then
	touch ${rc_deps}
fi
for dep_file in ${rc_deps}.*; do
	cat ${dep_file} >>${rc_deps}
	rm ${dep_file}
done

exit 0

