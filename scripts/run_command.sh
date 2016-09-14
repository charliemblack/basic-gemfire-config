#!/usr/bin/env bash

SAVED="`pwd`"
cd "`dirname \"$PRG\"`/.." >&-
POC_HOME="`pwd -P`"
cd "$SAVED" >&-

source ${POC_HOME}/scripts/env.sh

for currHost in $hosts $remotehosts
do
    echo ===== ${currHost} - Running "$@" ====
    ssh -o LogLevel=Error -t ${SSH_USER}@${currHost} '/usr/bin/env bash --login'  << ENDSSH
        $@
ENDSSH
  
done
