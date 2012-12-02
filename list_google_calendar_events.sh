#users:
user=time.it@bbvaglobalnet.com;p=mypassword;priv=db8f3b7a86264a8a34a80d65dcefc3aa

today=`date +"%Y-%m-%d"`

auth=`curl https://www.google.com/accounts/ClientLogin  --data-urlencode Email=$user --data-urlencode Passwd=$p -d accountType=GOOGLE  -d source=Google-cURL-Example  -d service=cl  | grep Auth=|awk -F= '{print $2}'`

#echo "Authorization: GoogleLogin auth=$auth"


#curl --silent --header "Authorization: GoogleLogin auth=$auth"  "https://www.google.com/calendar/feeds/default/allcalendars/full"
todaysfeeds="https://www.google.com/calendar/feeds/$user/private-$priv/full?start-min="$today"T00:00:00&start-max="$today"T23:59:59"

#curl --silent --header "Authorization: GoogleLogin auth=$auth" "$todaysfeeds" 

response=`curl --silent --header "Content-Type: application/atom+xml" --header "Authorization: GoogleLogin auth=$auth" "$todaysfeeds"`
echo $response
