#!/bin/bash

## uploading to google drive

det=`date +%F`
browser="Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:13.0) Gecko/20100101 Firefox/13.0.1"
username="myuser@gmail.com"
password="mypassword"
#accountype="HOSTED" #gooApps = HOSTED , gmail=GOOGLE
accountype="GOOGLE" #gooApps = HOSTED , gmail=GOOGLE
#mydir="/tmp"
mydir=`pwd`
file="hola.txt"
loginfile="$mydir/login.txt"
#tipe="application/x-tar"
tipe="text/plain"

if [ -f $loginfile ]; then
	token=`cat $loginfile | grep Auth | cut -d \= -f 2`
else
	curl -v --data-urlencode Email=$username --data-urlencode Passwd=$password -d accountType=$accountype -d service=writely -d source=cURL "https://www.google.com/accounts/ClientLogin" > $loginfile

	token=`cat $mydir/login.txt | grep Auth | cut -d \= -f 2`
fi

uploadlink=`curl -v -k --request POST  -H "Content-Length: 0" -H "Authorization: GoogleLogin auth=${token}" -H "GData-Version: 3.0" -H "Content-Type: $tipe" -H "Slug: $file" "https://docs.google.com/feeds/upload/create-session/default/private/full?convert=false"  2>&1 |grep upload_id| sed s/".*Location: "// `

curl -Sv -k --request POST --data-binary "@$file" -H "Authorization: GoogleLogin auth=${token}" -H "GData-Version: 3.0" -H "Content-Type: $tipe" -H "Slug: $file" "$uploadlink" > $mydir/goolog.upload.txt

