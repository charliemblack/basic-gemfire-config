#!/usr/bin/env bash


SAVED="`pwd`"
cd "`dirname \"$PRG\"`/.." >&-
POC_HOME="`pwd -P`"
cd "$SAVED" >&-

source ${POC_HOME}/scripts/env.sh


echo Starting Locator on $site_a
ssh  -o LogLevel=Error -T ${SSH_USER}@${site_a}  '/usr/bin/env bash --login'  << ENDSSH &
	cd ${remote_dir}
	${remote_dir}/scripts/start_locator.sh site_a
ENDSSH

echo Starting Locator on $site_b
ssh  -o LogLevel=Error -T ${SSH_USER}@${site_b}  '/usr/bin/env bash --login'  << ENDSSH &
	cd ${remote_dir}
	${remote_dir}/scripts/start_locator.sh site_b
ENDSSH


wait


echo Starting gemfire server on $site_a
ssh  -o LogLevel=Error -T ${SSH_USER}@${site_a} '/usr/bin/env bash --login'  << ENDSSH &
  cd ${remote_dir}
  ${remote_dir}/scripts/start_server.sh site_a
ENDSSH

echo Starting gemfire server on $site_b
ssh  -o LogLevel=Error -T ${SSH_USER}@${site_b} '/usr/bin/env bash --login'  << ENDSSH &
  cd ${remote_dir}
  ${remote_dir}/scripts/start_server.sh site_b
ENDSSH


wait
