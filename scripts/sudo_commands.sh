#!/usr/bin/env bash

if ! [ -x "$(command -v wget)" ]; then
   yum -y install wget
fi
