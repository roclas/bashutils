#!/usr/bin/env bash

function grepInPDFs {
	for i in $(find $2 -name "*pdf"|sort);do 
		text=pdftotext $i - | grep -i "$1"|sed "s/^/\t/";
		if [ ! -z "$text"  ];then
			echo $i
			pdftotext $i - | grep -i "$1"|sed "s/^/\t/";
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

function searchword {
        curl https://www.merriam-webster.com/dictionary/$1 | hxnormalize -x |hxselect '.card-primary-content'
}

