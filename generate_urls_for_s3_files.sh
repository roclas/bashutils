#!/usr/bin/env bash

##how to use:
##curl -s `./generate_urls_for_s3_files.sh mybucketname carlos/pruebas/objeto1.txt`

bucket=$1
object=$2

# 1-hour expiration
ts_exp=$((`date +%s` + 10800)) # Ireland's date(add 1 extra hour) (1 hour =3600; 3 hours=10800; 3hours=2hours in ireland)
# string to sign: GET + expiration-time + bucket/object
can_string="GET\n\n\n$ts_exp\n/$bucket/$object"
# generate the signature
sig=$(s3cmd sign "$(echo -e "$can_string")" | sed -n 's/^Signature: //p')
# extract access key from .s3cfg
s3_access_key=$(sed -n 's/^access_key = //p' ~/.s3cfg)

# sanity check
if [ -z "$s3_access_key" -o -z "$sig" ]; then
    echo "Failed to created signed URL for s3://$bucket/$object" >&2
    exit 1
fi

#base_url="https://s3.amazonaws.com/$bucket/$object"
base_url="https://s3-eu-west-1.amazonaws.com/$bucket/$object"
params="AWSAccessKeyId=$s3_access_key&Expires=$ts_exp&Signature=$sig"
echo -n "$base_url?$params"
