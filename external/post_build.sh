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
fake_files='etc/mdc_start.sh etc/run_script etc/run_script_ct'
for link in ${fake_files}; do
   [[ ! -e $link ]] && ln -sr etc/log_attempt.sh ${link}
done

exit 0

