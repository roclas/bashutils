a="a";b="b";
#filename="s3://mybucket/mydir/130521154900/"
filename=$1
email=$2
while [ "$a" != "$b" ]; do b=$a;a=`s3cmd ls $filename |awk '{print $2}'|sort -k1n|tail -1`; sleep 90; done
echo "your s3 file $filename is stable" | mail -s "your s3 file $filename is stable" $email
