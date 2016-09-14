#!/usr/bin/env bash

SAVED="`pwd`"
cd "`dirname \"$PRG\"`/.." >&-
POC_HOME="`pwd -P`"
cd "$SAVED" >&-

source ${POC_HOME}/scripts/env.sh

for currHost in ${hosts} ${remotehosts}
do
    echo ==== Synching $currHost
    rsync -avz  --exclude 'data' --exclude 'stats' --delete ${POC_HOME}/ ${SSH_USER}@${currHost}:${remote_dir}
done

