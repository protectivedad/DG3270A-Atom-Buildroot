#-----------------------------------------------------------------------------
# Copyright 2010-2014 Intel Corporation All Rights Reserved. 
#
# DISTRIBUTABLE AS SAMPLE SOURCE SOFTWARE
#
# This Distributable As Sample Source Software is subject to the terms and
# conditions of the Intel Software License Agreement provided with the Intel(R)
# Media Processor Software Development Kit.
#-----------------------------------------------------------------------------

#!/bin/sh
ME=`basename $0`
THIS=$1
NAME=`basename $1 | tr -d "/."`


EXIT_CODE=0

if [ -f /etc/rc3.d/$THIS ]; then

    if [ 2 -le $# ]; then
        shift
        for dep in $@ ; do
            # wait for dependencies
            /bin/init_man --name $NAME -W $dep
            if [ ! $? -eq 0 ]; then
                echo "************************************************************************"
                echo " ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR"
                echo ""
                echo "   $THIS TIMED OUT while waiting for dependency: $dep."
                echo ""
                echo " ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR"
                echo "************************************************************************"
                echo
                exit 1
            fi
        done
    fi

    # attempt to execute the script
    /etc/rc3.d/$THIS stop

    RET_VAL=$?
    if [ $RET_VAL -eq 0 ]; then
        echo "$THIS SUCCESS"
    else
        echo "************************************************************************"
        echo " ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR"
        echo ""
        echo "   $THIS FAILED [returned $RET_VAL]"
        echo "   You may need to check the dependencies: <$@>."
        echo ""
        echo " ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR"
        echo "************************************************************************"
        echo
        EXIT_CODE=1
    fi

else
    # missing symlink
    echo "*** /etc/rc3.d/$THIS not found, skipping"
fi

# always notify so that we release any waiters
/bin/init_man --name $NAME -N $NAME
exit $EXIT_CODE
