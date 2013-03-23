#!/bin/bash
if [ -z `which recordmydesktop` ]; then echo "you need to 'sudo apt-get install recordmydesktop' first"; return 0; fi


n=0
recordmydesktop -o my_video$n.ogv &
while :
do
	sleep 120
	ps -ef | grep recordmydesktop| grep my_video$n | awk '{print $2}' | xargs kill
	n=`echo $n|awk '{print $1+1}'`
	recordmydesktop -o my_video$n.ogv &
done
	
