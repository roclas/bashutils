#!/usr/bin/env bash

# Monitors a web page for changes

URL="$1"

for (( ; ; )); do
    mv .new.html .old.html 2> /dev/null
    curl $URL -L --compressed -s > .new.html
    DIFF_OUTPUT="$(diff .new.html .old.html)"
    if [ "0" != "${#DIFF_OUTPUT}" ]; then
	echo "$URL changed!!!!!!!!!!!!!"
    fi
    sleep 60
done
