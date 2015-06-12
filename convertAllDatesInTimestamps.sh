#!/usr/bin/env sh
cat $1 | gawk '
    {
	for(i=1;i<=NF;i++){
          if (match($i, /(....)-(..)-(..)/, m)) {
            t = mktime(m[1] " " m[2] " " m[3] " 00 00 00")
            epoch=strftime("%s", t) 
	    printf("%s ",epoch);
          }else{
	    printf("%s ",$i)
	  }
	}
	print " ";
     }
'
