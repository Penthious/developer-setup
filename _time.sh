#!/bin/bash

# Instructions
## Save this file to the root of where your projects are stored
## cd to the projects root directory and run chmod +x _timelog.sh
## Change Michael Bonner to your name as it's set in your git config
#
AUTHOR="Tomas"
ONE_MONTH_AGO=`date -j -v-1m`

rm -f ~/Desktop/timelog.txt

echo "Looking for entries for $AUTHOR"

for d in `find . -name .git -type d`; do
	cd $d/.. > /dev/null
	echo -e "\n${HIGHLIGHT}Checking `pwd`$NORMAL"
	git log --author="$AUTHOR" --after=ONE_MONTH_AGO --date=short --pretty=format:"%ai $d : %s" >> ~/Desktop/timelog.txt
	echo "\n" >> ~/Desktop/timelog.txt
	cd - > /dev/null
done

sort -r -o ~/Desktop/timelog.txt ~/Desktop/timelog.txt
atom ~/Desktop/timelog.txt
