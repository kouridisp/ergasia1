#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do 

	if [ "$line" != "#*" ] 
	then
            	wget "$line" -q -O "temp.txt"
		if [ $? == 0 ]
		then
		        hash=`md5sum temp.txt | awk '{print $1}'`
		        	    
		    
		    	if grep -Fxq "$line" exist_urls.txt  
		    	then
				if  grep -Fxq "$hash" exist_urls.txt
				then
					echo ""
			 	else
					string="$(grep "$line" -n exist_urls.txt)"
			    		txtline="$(cut -d':' -f1 <<< "$string")" 
					hashline=$(($txtline+1))		
					sed -i "${hashline}d" exist_urls.txt
					sed -i "${hashline}i${hash}\n" exist_urls.txt
					echo "$line"
				fi		   
			else
				echo "$line INIT"  
				echo "$line" >> exist_urls.txt
			   	echo "$hash" >> exist_urls.txt
				printf "\n" >> exist_urls.txt 
		        fi
		else
			>&2 echo "$line FAILED"
		fi
	fi
done < input.txt
