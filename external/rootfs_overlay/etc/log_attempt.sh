#!/bin/sh
#set -x

LOG_CMD=/usr/bin/logger

$LOG_CMD "==============================================================================="
$LOG_CMD "REMOVED PROGRAM EXECUTION DETECTED."

PARENT_ID=$PPID
CURRENT_ID=$$
CURRENT_COMMAND=$(ps -o pid,args | grep -m1 $CURRENT_ID | xargs)

$LOG_CMD "PROGRAM: $CURRENT_COMMAND"

while [ ! "$PARENT_ID" == "1" ]; do
   PARENT_PS=$(ps -o ppid,pid | grep -m1 $PARENT_ID | xargs)
   PARENT_COMMAND=$(ps -o pid,args | grep -m1 $PARENT_ID | xargs )
   if [ "$PARENT_COMMAND" != "$PARENT_ID -sh" ]; then
      $LOG_CMD "PREVIOUS PROGRAM: $PARENT_COMMAND"
   fi
   for pid in $PARENT_PS; do
      if [ "$PARENT_ID" == "$pid" ]; then
         PARENT_ID="1"
      else
         PARENT_ID=$pid
      fi
      break
   done
done

$LOG_CMD "==============================================================================="

