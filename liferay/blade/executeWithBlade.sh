#!/usr/bin/env bash

scriptname="script.groovy"
if test "${1+x}"; then
	scriptname=$1
fi
echo "running $PWD/$scriptname"
blade sh sh $PWD/executeScript.gosh $PWD/$scriptname groovy
