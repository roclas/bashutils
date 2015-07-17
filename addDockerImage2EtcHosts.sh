#!/usr/bin/env bash

if [ $# -lt 1 ];then
 echo "usage: $0 <docker_image_name_or_id>"
 exit 0
fi


etchostsfile="/etc/hosts"

ip=$(getContainerIP.sh $1) && sudo su - "root" -c "sed -i '/'$1'/d' $etchostsfile &&  echo $ip $1 >> $etchostsfile"
