#!/usr/bin/env bash

origin="./"
destination="../liferay-exercise-1"
while true; do
  change=$(inotifywait --format %w%f -r -e  close_write,moved_to,create $origin)
  file=$(echo $change | awk -F"/" '{print $NF}')
  if [[ $change =~ ^.*\.class$ ]] ; then
        target=$(find $destination -name $file)
        if [[ $target =~ ^.*\.class$ ]] ; then
                cp $change $target
        fi
  fi
done
