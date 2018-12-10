#!/bin/bash
secondversion(){
            	wget "$1" -q -O "temp.txt"
		if [ $? == 0 ]
		then
		        hash=`md5sum temp.txt | awk '{print $1}'`
		        	    
		    
		    	if grep -Fxq "$1" exist_urls.txt  
		    	then
				if  grep -Fxq "$hash" exist_urls.txt
				then
					echo ""
			 	else
					string="$(grep "$1" -n exist_urls.txt)"
			    		txtline="$(cut -d':' -f1 <<< "$string")" 
					hashline=$(($txtline+1))		
					sed -i "${hashline}d" exist_urls.txt
					sed -i "${hashline}i${hash}\n" exist_urls.txt
					echo "$1"
				fi		   
			else
				echo "$1 INIT"  
				echo "$1" >> exist_urls.txt
			   	echo "$hash" >> exist_urls.txt
				printf "\n" >> exist_urls.txt 
		        fi
		else
			>&2 echo "$1 FAILED"
		fi
}
while IFS='' read -r line || [[ -n "$line" ]]; do 

	if [ "$line" != "#*" ] 
	then 
		secondversion $line &
	fi
done < input.txt
