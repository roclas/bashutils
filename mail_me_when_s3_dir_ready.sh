#filename="s3://mybucket/mydir/130521154900/"
filename=$1
email=$2
echo "filename=$filename"
echo "mail=$email"
a="`s3cmd ls $filename`"
echo "a=$a"
while [ "$a" == "" ]; do echo "not ready" ; sleep 3; done
echo "your s3 file $filename has been created" | mail -s "your s3 file $filename has been created" $email
