#!/bin/bash
tar -xzf $1 -C extract
if [ $# -eq 0 ]
then
echo "Usage : script2.sh [tar filename]"
exit 1;
fi

cd extract
for archive in $(find . -type f -name '*.txt');
do
	while IFS='' read -r line || [[ -n "$line" ]];
	do
	
		if [[ "$line" == "https"* ]]
		then 
			cd ..
			cd cloned
			git clone $line 2>/dev/null 
			if [ $? == 0 ]
			then 
				echo "$line Cloning OK"
				
			else
				>&2 echo "$line Cloning FAILED"
			fi
			cd ..
			cd extract
			break
		fi
	done < $archive
done
cd ..
cd cloned
for archive in $(ls);
do	
	echo "$archive"
	cd $archive
	dircount=$(find . -type d | wc -l)
	txtcount=$(find . -type f -name '*.txt'| wc -l)
	othercount=$(find . -type f ! -name '*.txt' | wc -l)
	echo "directory number is : $dircount"
	echo "files number is : $txtcount"
	echo "other files number is : $othercount"
	ls dataA.txt more/dataB.txt more/dataC.txt -R 2>/dev/null
	if [ $? == 0 ]
	then
		count=$(find . -not -path '*/\.*' | wc -l)
		if [ $count == "5" ]
		then 
		echo "structure is OK"
		else 
                echo "structure in not OK"
		fi
	else echo "structure is not OK"
	fi
	cd ..

	 

		
done

