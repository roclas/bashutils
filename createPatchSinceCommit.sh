#!/bin/bash

# Explains how to use the script
usage()
{
cat << EOF
usage: $0 options

$0 -o output_file.zip commit_from [commit_to]

Description:
  The script creates a zipped archive of only modified files in a git repository

OPTIONS:
  -h  Shows this message
  -o  Optional. Sets the output file.
EOF
}

# Create the variables used
FILENAME=

# Extract the arguments
while getopts "ho:" flag
do
  case $flag in
    h)
      usage
      exit 1
      ;;
    o)
      FILENAME=$OPTARG
      shift
      ;;
  esac

  shift
done

FROM=$1
TO=$2
: ${TO:="HEAD"}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi
git diff -z --name-only $FROM $TO | xargs -0 git archive $TO -o $FILENAME --
