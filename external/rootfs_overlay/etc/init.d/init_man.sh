#-----------------------------------------------------------------------------
# Copyright 2010-2014 Intel Corporation All Rights Reserved. 
#
# DISTRIBUTABLE AS SAMPLE SOURCE SOFTWARE
#
# This Distributable As Sample Source Software is subject to the terms and
# conditions of the Intel Software License Agreement provided with the Intel(R)
# Media Processor Software Development Kit.
#-----------------------------------------------------------------------------

#-------------------------------------------------------------
# usage
#
#   init_man.sh start
#   init_man.sh stop
#   init_man.sh start <script>
#   init_man.sh stop <script>
#-------------------------------------------------------------
# dependency graph: many-to-many
#   one service can have multiple dependencies
#   one dependency can enable multiple services

#-------------------------------------------------------------
# parse command line

if [ "$1" == "start" ] || [ "$1" == "stop" ]; then
    mode="$1"
    shift
    # get the list of all services that must be started
    if [ -n "$*" ]; then
        target="$*"
    else
        target=""
    fi
else
    echo "usage: $0 {start|stop} [script(s)...]"
    exit 1
fi

timeout=""
if [ "$mode" == "start" ]; then
    # timeout after 90 sec for each script
    timeout="--timeout 90 --warn 30"
elif [ "$mode" == "stop" ]; then
    # timeout after 60 sec total
    timeout="--total"
fi

#-------------------------------------------------------------
# generate the dependency list

SRVS=`/bin/init_man -l $mode $target`

#-------------------------------------------------------------
# 1. initialize semaphores for all services in the list
# 2. for each service, start it, waiting on any dependencies
# 3. wait for all services to complete
# 4. delete semaphores

# initialize semaphores
/bin/init_man --name init_man.sh -S $SRVS

# start each script with dependencies
( /bin/init_man -d $mode $target | sed -e s/^\(.*\)$/\"\1\"/g ) | while read line ; do
    /etc/init.d/${mode}_service.sh $line &
done

# wait for completion
/bin/init_man --name init_man.sh $timeout -W $SRVS

# delete semaphores
/bin/init_man --name init_man.sh -R $SRVS

exit 0

