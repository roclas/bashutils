#!/usr/bin/env bash

if [ $# -lt 1 ];then
 echo "usage: $0 <docker_image_name_or_id>"
 exit 0
fi

#docker exec -it $1 /sbin/ip addr show | grep 172 | awk '{print $2}' | awk -F"/" '{print $1}'
docker inspect -f '{{.NetworkSettings.IPAddress}}' $1
