#users:
user=time.it@bbvaglobalnet.com;p=mypassword;priv=db8f3b7a86264a8a34a80d65dcefc3aa

today=`date +"%Y-%m-%d"`

auth=`curl https://www.google.com/accounts/ClientLogin  --data-urlencode Email=$user --data-urlencode Passwd=$p -d accountType=GOOGLE  -d source=Google-cURL-Example  -d service=cl  | grep Auth=|awk -F= '{print $2}'`

#echo "Authorization: GoogleLogin auth=$auth"


#curl --silent --header "Authorization: GoogleLogin auth=$auth"  "https://www.google.com/calendar/feeds/default/allcalendars/full"
todaysfeeds="https://www.google.com/calendar/feeds/$user/private-$priv/full?start-min="$today"T00:00:00&start-max="$today"T23:59:59"
createevent="https://www.google.com/calendar/feeds/default/private/full" 

eventtext="
<entry xmlns='http://www.w3.org/2005/Atom' xmlns:gd='http://schemas.google.com/g/2005'>
<category scheme='http://schemas.google.com/g/2005#kind' term='http://schemas.google.com/g/2005#event'></category>
<title type='text'>Tennis with Beth</title>
<content type='text'>Meet for a quick lesson.</content>
<gd:transparency value='http://schemas.google.com/g/2005#event.opaque'>
</gd:transparency>
<gd:eventStatus value='http://schemas.google.com/g/2005#event.confirmed'>
</gd:eventStatus>
<gd:where valueString='Rolling Lawn Courts'></gd:where>
<gd:when startTime='"$today"T15:00:00.000Z' endTime='"$today"T15:30:00.000Z'></gd:when>
</entry>"

echo $eventtext > newevent.xml

#curl --silent --header "Authorization: GoogleLogin auth=$auth" "$todaysfeeds" 
response=`curl --silent --request POST --data-binary "@newevent.xml" --header "Content-Type: application/atom+xml" --header "Authorization: GoogleLogin auth=$auth" "$createevent"`
gsessionid=`echo $response|grep gsessionid | sed s/.*gsessionid=// | sed s/\".*//`
response=`curl --silent --request POST --data-binary "@newevent.xml" --header "Content-Type: application/atom+xml" --header "Authorization: GoogleLogin auth=$auth" "$createevent?gsessionid=$gsessionid"`
echo $response
