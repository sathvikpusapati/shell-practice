#!/bin/bash

R="\e[31m"
Y="\e[32m"
G="\e[33m"
N="\e[0m"

id=$(id -u)

log_folder="/var/log/shell-practice"

script_name=$( echo $0 | cut -d "." -f1 )

log_file=$log_folder/$script_name.log 


mkdir -p $log_folder

echo  "SCRIPT EXECUTED AT $(date) " | tee -a $log_file

SOURCE_DIR="/home/ec2-user/app-logs"

if [ ! -d $SOURCE_DIR ]; then
    echo -e "ERROR :: $SOURCE_DIR dose not exist "
    exit 1
fi

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type f -mtime -14)

while IFS= read -r filepath 
do
    echo "deleting this file $filepath"

    rm -rf $filepath

    echo "deleted the file $filepath"

done <<< $FILES_TO_DELETE