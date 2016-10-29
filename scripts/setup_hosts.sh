#!/usr/bin/env bash


function waitForPort() {
# 1 - hostname
# 2 - port

    (exec 6<>/dev/tcp/${1}/${2}) &>/dev/null
    while [ $? -ne 0 ]
    do
        echo -n "."
        sleep 1
        (exec 6<>/dev/tcp/${1}/${2}) &>/dev/null
    done
}

# Attempt to set APP_HOME
# Resolve links: $0 may be a link
PRG="$0"
# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`"/$link"
    fi
done
SAVED="`pwd`"
cd "`dirname \"$PRG\"`" >/dev/null
APP_HOME="`pwd -P`"
cd "$SAVED" >/dev/null

echo app home - ${APP_HOME}

source ${APP_HOME}/env.sh

for currHost in "${all_hosts[@]}"
do
    ssh-keyscan -t rsa,dsa $currHost 2>&1 | sort -u - ~/.ssh/known_hosts > ~/.ssh/tmp_hosts
    mv ~/.ssh/tmp_hosts ~/.ssh/known_hosts
    echo setting up $currHost
    scp ${APP_HOME}/install_gemfire.sh ${user}@${currHost}:~/
    scp ${APP_HOME}/sudo_commands.sh ${user}@${currHost}:~/
    ssh -t ${user}@${currHost} 'bash -s' <<ENDSSH
        export LOCATORS=${LOCATORS}
        export influxDBHost=${influxDBHost}
        chmod a+x ./install_gemfire.sh
        chmod a+x ./sudo_commands.sh
ENDSSH
    ssh -t ${user}@${currHost} "sudo /home/${user}/sudo_commands.sh"

    ssh -t ${user}@${currHost} 'bash -s' <<ENDSSH
        ./install_gemfire.sh
ENDSSH

done

${APP_HOME}/deploy.sh
