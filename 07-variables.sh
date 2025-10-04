#!/bin/bash

DATE=$(date) #this will run the date command and store in DATE variable

echo "Timestamp executed :$DATE"

START_TIME=$(date +%s)

sleep 10

END_TIME=$(date +%s)

TOTAL_TIME=$(($START_TIME-$END_TIME))

echo "process done in $TOTAL_TIME"
