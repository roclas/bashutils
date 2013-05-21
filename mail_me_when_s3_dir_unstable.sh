a=`s3cmd ls $filename |awk '{print $2}'|sort -k1n|tail -1`
b=$a
#filename="s3://mybucket/mydir/130521154900/"
filename=$1
email=$2
while [ "$a" == "$b" ]; do b=$a;a=`s3cmd ls $filename |awk '{print $2}'|sort -k1n|tail -1`; sleep 90; done
echo "your s3 dir $filename has started to change" | mail -s "your s3 dir $filename has started to change " $email
