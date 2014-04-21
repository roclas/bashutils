#!/usr/bin/env bash

if [ ! $(which jad) ]
then
	echo "you need to install the jad decompiler first"
	exit -1
fi

jarfile=$1
if [ ! $(echo $jarfile|grep "\.jar$") ]
then
	echo "the input file is not a jar file"
	exit -1
fi

workingdir=$(echo /tmp/$jarfile | sed "s/\.jar//")

rm -rf $workingdir

unzip $jarfile -d $workingdir

for i in $(find $workingdir -name "*.class")
do
  dest=$(echo $i | sed "s/\.class$/\.java/")
  tempfile=$(echo $i | awk -F"/" '{print $NF}' |sed "s/\.class$/\.jad/")
  jad $i
  mv $tempfile $dest
done

cd $workingdir
zip -r $jarfile"_with_sources" ./
cd -

mv $workingdir/$jarfile"_with_sources" .
