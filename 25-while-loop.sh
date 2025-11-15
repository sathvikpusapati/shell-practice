#!/bin/bash

#count=5

##echo "starting countdown...."

#while [ $count -gt 0 ]
#do
#   sleep 1
#    count=$((count - 1))
#done

#echo "Times Up !"

while IFS= read -r  line ; do

    echo "processing line : $line"

done < 22-script-1.sh