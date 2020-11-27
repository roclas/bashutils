#!/usr/bin/env bash

watch0() {
echo watching folder $1/ and then doing $2...
while [[ true ]]
do
    files=`find $1 -type f -mmin -0.05 `
    if [[ $files == "" ]] ; then
	sleep 0
    else
	    eval "$2"
    fi
    sleep 3
done
}

