#!/usr/bin/env bash

inotifywait -r -m . -e create -e moved_to | #-e modify|
    while read path action file; do
        echo "The file '$file' appeared in directory '$path' via '$action'"
        # do something with the file
    done
