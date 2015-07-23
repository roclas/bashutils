#!/usr/bin/env bash

function grepInPDFs {
	for i in $(find $2 -name "*pdf"|sort);do echo $i;pdftotext $i - | grep -i "$1"|sed "s/^/\t/";done
}  

function grepClassInJars {
	for i in $(find $2 -name "*jar"|sort);do echo $i;jar -tf $i | grep -i "$1"|sed "s/^/\t/";done
}

