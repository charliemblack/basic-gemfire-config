#!/usr/bin/env bash


SAVED="`pwd`"
cd "`dirname \"$PRG\"`/.." >&-
POC_HOME="`pwd -P`"
cd "$SAVED" >&-

source ${POC_HOME}/scripts/env.sh

export POC_HOME

locatorArray=(${locators})

ssh  -o LogLevel=Error -T ${SSH_USER}@${locatorArray[0]} '/usr/bin/env bash --login'  << ENDSSH
gfsh << ENDGFSH
connect --locator=${locatorArray[0]}[10334]
shutdown --include-locators=true --time-out=30
Y
ENDGFSH
ENDSSH