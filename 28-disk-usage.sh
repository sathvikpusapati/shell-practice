#!/bin/bash

DISK_USAGE=$( df -hT | grep -v Filesystem )
DISK_THRESHOLD=2 # in companies and projects the  threshold value is 75

while IFS= read -r line 
do
    echo "line : $line"
    USAGE=$(df -hT | awk '{print $6}'| cut -d "%" -f1)
    PARTITION=$(df -hT | awk '{print $7}')

    if [ $USAGE -ge $DISK_THRESHOLD]; then
        echo "HIGH USAGE ON $PARTITION $USAGE"
    fi
done <<< $DISK_USAGE