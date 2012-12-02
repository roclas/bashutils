for i in `find $1 -type f`; do 
	cp $i `echo $i | sed s@^$1@$2@`; 
done
