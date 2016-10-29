#!/usr/bin/env bash


called=$_
if [[ $called == $0 ]] ; then
    echo "This file needs to be sourced it can't be run.  Usage: source $0"
    exit 1
fi



# Attempt to set APP_HOME
# Resolve links: $0 may be a link
PRG="$_"
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

source ${APP_HOME}/env.sh

# Setup the ssh so I don't need the pem everywhere
ssh-add
ssh-add ~/.ssh/pivotal-pde-ec2.pem

c=1
for currHost in "${data_hosts[@]}"
do
    echo "Createing ssh alias for $currHost as ssh_gf$c"
    eval "alias ssh_gf$c='ssh ${user}@$currHost'"
    c=$((c+1));
done

c=1
for currHost in "${locator_hosts[@]}"
do
    echo "Createing ssh alias for $currHost as ssh_locator$c"
    eval "alias ssh_locator$c='ssh ${user}@$currHost'"
    c=$((c+1));
done

alias
