#!/bin/bash

DISK_USAGE=$( df -hT | grep -v Filesystem )
DISK_THRESHOLD=2 # in companies and projects the  threshold value is 75
IP_ADDRESS=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
while IFS= read -r line 
do
    USAGE=$(echo $line | awk '{print $6}'| cut -d "%" -f1)
    PARTITION=$(echo $line | awk '{print $7}')
    if [ $USAGE -ge $DISK_THRESHOLD ] ; then
        MESSAGE+="HIGH USAGE ON $PARTITION : $USAGE % \n" # by putting + it will append 
    fi
done <<< $DISK_USAGE

echo -e "message body : $MESSAGE" # -e means escape characters 

sh 27-gmail.sh "pusapatisathvik@gmail.com" "HIGH DISK USAGE ALERT " "HIGH DISK USAGE" "$MESSAGE" "$IP_ADDRESS"

# TO_ADDRESS=$1
# SUBJECT=$2
# ALERT_TYEPE=$3
# MESSAGE_BODY=$4
# IP_ADDRESS=$5