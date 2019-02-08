#!/usr/bin/env bash

files=""

inotifywait -r -m . -e create -e modify |
    while read path action file; do
	#if file is one of my files...
        echo "The file '$file' modified in directory '$path' via '$action'"
	cp $path/$file ~/Desktop/
    done
