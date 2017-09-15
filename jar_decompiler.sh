#!/usr/bin/env bash

#classpathroot=$PWD
classpathroot=/home/carlos/Liferay/bundles/dxp/liferay-dxp-digital-enterprise-7.0-sp1

classpath="."
for i in $(find $classpathroot -name "*.jar" );do
	classpath="$classpath:$i"
done
echo "classpath= $classpath"


executionDir=$(pwd)
aspectfile=~/lib/java/LogAllAspect

if [ ! $(which javap) ]
then
	echo "you need to install the java decompiler first"
	exit -1
fi

jarfile=$1
if [ ! $(echo $jarfile|grep "\.jar$") ]
then
	echo "the input file is not a jar file"
	exit -1
fi

workingdir=$(echo /tmp/$jarfile | sed "s/\.jar//")
echo "workingdir=$workingdir"
rm -rf $workingdir 2>/dev/null

mkdir -p $workingdir
#unzip $jarfile -d $workingdir
java -jar /home/carlos/programs/decompilers/jd/jd-core.jar /home/carlos/projects/bundles/tomcat-8.0.32/webapps/ROOT/WEB-INF/lib/portal-impl.jar $workingdir

#for i in $(find $workingdir -name "*.class")
for i in $(find $workingdir -name "*.java")
do
  #dest=$(echo $i | sed "s/\.class$/\.java/") 
  #tempfile=$(echo $i | awk -F"/" '{print $NF}' |sed "s/\.class$/\.jad/")
  #jad $i 
  #javap -classpath $CLASSPATH:$classpath $i | tail -n +2 >$tempfile
  #echo "moving $tempfile to $dest"
  #mv $tempfile $dest
  ##waive the aspect into the class
  #ajc -cp "$CLASSPATH:$classpath:/home/carlos/lib/java" $aspectfile.java $dest 
  ajc -cp "$CLASSPATH:$classpath:/home/carlos/lib/java" $aspectfile.java $i
done

cd $workingdir

##put the aspect inside the jar
cp $aspectfile.class ./

zip -r $jarfile"_with_sources.jar" ./
mv $jarfile"_with_sources.jar"  $executionDir
cd -

