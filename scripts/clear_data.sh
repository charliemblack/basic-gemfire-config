#!/usr/bin/env bash

SAVED="`pwd`"
cd "`dirname \"$PRG\"`/.." >&-
POC_HOME="`pwd -P`"
cd "$SAVED" >&-

DATA_HOME=${POC_HOME}/data

source ${POC_HOME}/scripts/env.sh


for currHost in ${hosts} ${remotehosts}
do
    echo Clearing ${currHost} the data dir is ${remote_dir}
    ssh  -o LogLevel=Error -T ${SSH_USER}@${currHost} '/usr/bin/env bash --login'  << ENDSSH
        #commands to run on remote host
       find ${remote_dir}/data -type f -delete
       mkdir -p ${remote_dir}/data/client
       mkdir -p ${remote_dir}/data/locator
       mkdir -p ${remote_dir}/data/server
ENDSSH
done

wait
