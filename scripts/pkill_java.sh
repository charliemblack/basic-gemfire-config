#!/usr/bin/env bash

SAVED="`pwd`"
cd "`dirname \"$PRG\"`/.." >&-
POC_HOME="`pwd -P`"
cd "$SAVED" >&-

source ${POC_HOME}/scripts/env.sh

for currHost in ${hosts} ${remotehosts}
do
    ssh  -o LogLevel=Error -T ${SSH_USER}@${currHost} 'bash -s' <<ENDSSH &
        #commands to run on remote host
        echo killing java on ${currHost}
        pkill -9 java
ENDSSH
done
wait

