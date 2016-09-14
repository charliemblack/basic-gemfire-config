#!/usr/bin/env bash

SAVED="`pwd`"
cd "`dirname \"$PRG\"`/" >&-
POC_HOME="`pwd -P`"
cd "$SAVED" >&-

echo $POC_HOME
DATA_HOME=${POC_HOME}/data

export CLASSPATH=

mkdir -p ${DATA_HOME}/locator > /dev/null 2>&1

echo Starting locator using properties file $1

gfsh start locator --name=locator_`hostname`  --initial-heap=128m --max-heap=128m --dir=${DATA_HOME}/locator --properties-file=${POC_HOME}/config/${1}.properties
