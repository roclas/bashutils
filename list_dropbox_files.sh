#!/usr/bin/env bash 

appkey="<your_dropbox_appkey>"
appsecret="<your_dropbox_appsecret>"

function extractparams {
 variables=`echo $1 |awk -F"&|=" '{print "export "$1"="$2"\nexport "$3"="$4}'`
 echo $variables
 $variables
}  

requesttoken="https://api.dropbox.com/1/oauth/request_token"

auth_variables=`curl --header 'Authorization: OAuth oauth_version="1.0", oauth_signature_method="PLAINTEXT", oauth_consumer_key="'$appkey'", oauth_signature="'$appsecret'&"' $requesttoken `
extractparams $auth_variables 

requestauth="https://www.dropbox.com/1/oauth/authorize?oauth_token=$oauth_token&oauth_callback=http://localhost:9005"
chromium-browser $requestauth

responseparams=`netcat -l 9005 < 200ok.json 2>&1 | grep GET| awk '{print $2}'| sed "s/^.*?//" `
extractparams $responseparams

#TODO not finished (we only got the authentication params), we only need to call the list endpoint
