#!/usr/bin/env bash


SAVED="`pwd`"
cd "`dirname \"$PRG\"`/.." >&-
POC_HOME="`pwd -P`"
cd "$SAVED" >&-

source ${POC_HOME}/scripts/env.sh

for currHost in ${locators}
do
	echo Starting Locator on $currHost for site a
	ssh  -o LogLevel=Error -T ${SSH_USER}@${currHost}  '/usr/bin/env bash --login'  << ENDSSH &
	cd ${remote_dir}
	${remote_dir}/scripts/start_locator.sh site_a
ENDSSH
done

wait

for currHost in ${hosts}
do
	echo Starting gemfire server on $currHost for site a
    ssh  -o LogLevel=Error -T ${SSH_USER}@${currHost} '/usr/bin/env bash --login'  << ENDSSH &
    cd ${remote_dir}
	${remote_dir}/scripts/start_server.sh site_a
ENDSSH
done

wait

