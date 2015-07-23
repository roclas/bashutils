#!/usr/bin/env bash

function grepPDF {
	for i in $(find $1 -name "*pdf");do echo $i;pdftotext $i - | grep -i "$2";done
}  

