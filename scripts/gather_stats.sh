#!/usr/bin/env bash


SAVED="`pwd`"
cd "`dirname \"$PRG\"`/.." >&-
POC_HOME="`pwd -P`"
cd "$SAVED" >&-

source ${POC_HOME}/scripts/env.sh
REMOTE_DATA_HOME=${remote_dir}/data

find ${POC_HOME}/stats -type f -delete

for currHost in ${hosts} ${remotehosts}
do
    mkdir -p ${POC_HOME}/stats/${currHost}
    rsync -avz --delete ${SSH_USER}@${currHost}:${REMOTE_DATA_HOME}/server/*.gfs ${POC_HOME}/stats/${currHost} &
    rsync -avz --delete ${SSH_USER}@${currHost}:${REMOTE_DATA_HOME}/server/*.log ${POC_HOME}/stats/${currHost} &
done

wait
