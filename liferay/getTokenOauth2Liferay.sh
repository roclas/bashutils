#!/usr/bin/env bash

clientId="id-42309f12-5f6b-b8f7-2edd-f88575c9caf"
secret="secret-6b52bf4a-6932-be5e-e3d3-b2414c92304d"

###first we ask for authorization and we get redirected
url1=$(curl -v "http://localhost:8080/o/oauth2/authorize?response_type=code&client_id=$clientId" 2>&1 | grep Location | awk '{print $3}'|strings)


###second we are redirected again (to a liferay login form)
url2=$(curl -v "$url1" 2>&1 | grep Location | awk '{print $3}'| strings)
if [[ "$url2" == *"LoginPortlet"* ]]; then
	echo "login manually here: $url2"
	nc -l 1234 | while read l;do
		c=$(echo $l | grep "code=" | xargs)
		if( [[ ! -z "$c" ]] ); then
			cod=$(echo $c| awk '{print $2}' | awk -F= '{print $2}')
			if( [[ ! -z "$(echo $cod| xargs)" ]] ); then
				echo "code =$cod"
				( nc -l -p 1234 2>&1 | grep access_token | while read l;do echo $l;exit 0;done)&
				curl -d "client_id=$clientId&client_secret=$secret&grant_type=authorization_code&code=$cod&redirect_uri=http://localhost:1234" -v "http://localhost:8080/o/oauth2/token" 2>/dev/null | grep access_token| head -1 | json_pp
				exit 0	
			fi
		else 
			echo "already logged in!! (1)"
		fi
	done
else ###if we are not redirected again because we are already logged in
	echo "already logged in!! (2)"
fi
