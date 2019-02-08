#!/usr/bin/env bash

function findFilesThatContain(){grep -ri $1 .| awk -F: '{print $1}' | sort | uniq}

function grepInPDFs {
	directory=$2
	string=$1
	for i in $(find $directory -name "*pdf"|sort);do 
		text=$(pdftotext "$i" - | tail -n +2 |grep -i "$string"|sed "s/^/\t/")
		if [ ! -z "$text"  ];then
			echo "\n\n$i"
			pdftotext "$i" - | tail -n +2| grep -i "$string"|sed "s/^\([\"']\)\(.*\)\1\$/\2/g"|sed "s/^/\t/";
		fi
	done
}  

function grepClassInJars {
	for i in $(find $2 -name "*jar"|sort);do 
		text=$(jar -tf $i | grep -i "$1"|sed "s/^/\t/")
		if [ ! -z "$text"  ];then
			echo "\n\n$i\n$text"
		fi
	done
}

function grepTextInJars {
	for i in $(find $2 -name "*jar"|sort);do 
		for k in $(jar -tf $i); do
			text=$(unzip -p $i $k| grep -i "$1"|sed "s/^/\t/")
			if [ ! -z "$text"  ];then
				echo "\n\n$i ($k):\n$text"
			fi
		done
	done
}

function grepTextInLpkgs {
	find $2 -name "*lpkg"| sort | while read i;do
		for j in $(jar -tf "$i" | grep jar);do
			text=$(unzip -q -c "$i" "$j" | grep -i "$1" |sed "s/^/\t/")
			if [ ! -z "$text"  ];then
				echo "$i/$j contains $1"
				#unzip -q -c "$i" "$j" | grep -i "$1"|sed "s/^/\t/" | uniq
			fi
		done
	done
}

function searchw {
        curl https://www.merriam-webster.com/dictionary/$1 | hxnormalize -x |hxselect '.card-primary-content' >/tmp/delete.html
	google-chrome /tmp/delete.html
}

