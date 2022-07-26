#!/usr/bin/env bash

function findFilesThatContain(){grep -ri $1 .| awk -F: '{print $1}' | sort | uniq}

function grepInPDFs {
	directory=$2
	string=$1
	for i in $(find $directory -name "*.pdf"|sort);do 
		text=$(pdftotext "$i" - | tail -n +2 |grep -i "$string"|sed "s/^/\t/")
		if [ ! -z "$text"  ];then
			echo "\n\n$i"
			pdftotext "$i" - | tail -n +2| grep -i "$string"|sed "s/^\([\"']\)\(.*\)\1\$/\2/g"|sed "s/^/\t/";
		fi
	done
}  

function grepClassInJars {
	for i in $(find $2 -name "*.jar"|sort);do 
		text=$(jar -tf $i | grep -i "$1"|sed "s/^/\t/")
		if [ ! -z "$text"  ];then
			echo "\n\n$i\n$text"
		fi
	done
}



function grepTextInJars {
	for i in $(find $2 -name "*.jar"|sort);do 
		for k in $(jar -tf $i); do
			text=$(unzip -p $i $k| grep -i "$1"|sed "s/^/\t/")
			if [ ! -z "$text"  ];then
				echo "\n\n$i ($k):\n$text"
			fi
		done
	done
}

function grepTextInWars {
	for i in $(find $2 -name "*.war"|sort);do 
		for k in $(jar -tf $i); do
			text=$(unzip -p $i $k| grep -i "$1"|sed "s/^/\t/")
			if [ ! -z "$text"  ];then
				echo "\n\n$i ($k):\n$text"
			fi
		done
	done
}

function grepTextInLpkgs {
	find $2 -name "*.lpkg"| sort | while read i;do
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

####################
###Usage############
####################
##myvar=myvalue
##generateFromTemplate myTemplatefile.txt (which contains ${myvalue}
####################
function generateFromTemplate {
	echo "generating from template $1..."
	#cat $1 | perl -p -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' 
	perl -pe 's|\$([A-Za-z_]+)|$ENV{$1}|g' $1
}

watch0() {
echo watching folder $1/ and then doing $2...
while [[ true ]]
do
    files=`find $1 -type f -mmin -0.05 `
    if [[ $files == "" ]] ; then
        sleep 0
    else
            eval "$2"
    fi
    sleep 3
done
}

compileAgainstLiferayOnlyJars() {
 javafile=$1
 portalfolder=$2
 if [ $# -lt 3 ]; then; extraclasspath="/tmp"; else; extraclasspath=$3; fi
 echo "file to compile=$1"
 echo "bundle folder to compile against=$2"
 classpath=$(find $portalfolder -name "*.jar"| tr '\n' ':').
 classpath=$classpath:$(find /tmp/ -name "*.jar"| tr '\n' ':')"/tmp:$extraclasspath"
 javac -cp "$classpath" $javafile
}

compileAgainstLiferayExplodingLpkgs() {
 find $2 -name "*.lpkg"| while read l; do; echo "unzipping $l into /tmp/" && yes|unzip "$l" -d /tmp/ ;done
 if [ $# -lt 3 ]; then; e="/tmp"; fi
 compileAgainstLiferayOnlyJars $1 $2 $e # $e are the extra classpath folders
}


injectClassInLiferayLpkg() {
 if [ $# -lt 3 ];then
	file=$1;bundle=$2
 	grepTextInLpkgs $file $bundle
 	echo "usage $0 your.lpkg jarInsideLpkg.jar $1"
 else
	lpkgFile=$1;jarFileInside=$2;classFile=$3
	echo "\n\n steps:\n--------------------------"
	echo "jar -xf '$lpkgFile' $jarFileInside"
 	echo "and then ..."
 	echo "jar uf $jarFileInside $classFile"
 	echo "zip -ur '$lpkgFile' $jarFileInside "
 fi
}

ncolumn(){ awk '{print $'$1'}' < /dev/stdin }


bashmap () {         
	zero="$@"
        while read i
        do
		#echo "$($@ $i)"
		set "$i"
        	$zero $1 $2 $3 $4 $5 $6 $7 $8 $9
		set --
        done

}

