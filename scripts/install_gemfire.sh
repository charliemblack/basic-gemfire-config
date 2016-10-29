#!/usr/bin/env bash

cd

if [ ! -d "jdk1.8.0_101" ]; then
    echo Downloading JDK
	wget --no-verbose https://dl.dropboxusercontent.com/u/24773097/jdk-8u101-linux-x64.tar.gz
	echo Uncompressing JDK
	tar zxf jdk-8u101-linux-x64.tar.gz
	rm -rf jdk-8u101-linux-x64.tar.gz
fi

if [ ! -d "Pivotal_GemFire_821_b18207_Linux" ]; then
    echo Downloading GemFire
	wget --no-verbose https://dl.dropboxusercontent.com/u/24773097/Pivotal_GemFire_821_b18207_Linux.tar.gz
	echo Uncompressing GemFire
	tar zxf Pivotal_GemFire_821_b18207_Linux.tar.gz
	rm -rf Pivotal_GemFire_821_b18207_Linux.tar.gz
fi


if [ ! -d "bashProfile" ]; then
	mkdir bashProfile
	echo export JAVA_HOME=~/jdk1.8.0_101 >> ~/.bash_profile
	echo export GEMFIRE_HOME=~/Pivotal_GemFire_821_b18207_Linux >> ~/.bash_profile
	echo 'export PATH=${JAVA_HOME}/bin:${GEMFIRE_HOME}/bin:${PATH}'  >> ~/.bash_profile
	echo export DEQUEUELOCATORS=${LOCATORS} >> ~/.bash_profile
	echo export influxDBHost=${influxDBHost}  >> ~/.bash_profile
	. ~/.bash_profile
fi
