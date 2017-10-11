#!/usr/bin/env bash

function grepInPDFs {
	directory=$2
	string=$1
	for i in $(find $directory -name "*pdf"|sort);do 
		text=$(pdftotext $i - | tail -n +2 |grep -i "$string"|sed "s/^/\t/")
		echo $text
		if [ ! -z "$text"  ];then
			echo $i
			pdftotext $i - | tail -n +2| grep -i "$string"|sed "s/^\([\"']\)\(.*\)\1\$/\2/g"|sed "s/^/\t/";
		fi
	done
}  

function grepClassInJars {
	for i in $(find $2 -name "*jar"|sort);do 
		text=$(jar -tf $i | grep -i "$1"|sed "s/^/\t/")
		if [ ! -z "$text"  ];then
			echo $i
			jar -tf $i | grep -i "$1"|sed "s/^/\t/"
		fi
	done
}

function grepClassInLpkgs {
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

