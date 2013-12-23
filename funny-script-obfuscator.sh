#!/usr/bin/env sh

echo "echo $(base64 $1)" > $2
chmod +x $2
