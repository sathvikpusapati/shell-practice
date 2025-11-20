#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

id=$(id -u)

log_folder="/var/log/shell-practice"

script_name=$( echo $0 | cut -d "." -f1 )

# log_file=$log_folder/$script_name.log 

log_file=$log_folder/backup.log  # modified for running script as command

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if not provided consider as 14 days




sudo mkdir -p $log_folder 

if [ $id -ne 0 ]; then
    echo -e "$R please give root access to continue$N" | tee -a $log_file
    exit 1
fi

USAGE(){

    echo -e "$R usage :: sudo sh backup.sh <source_dir> <destination_dir> <days>[optional, default 14 days] " | tee -a $log_file
    exit 1
}

if [ $# -lt 2 ]; then &>> $log_file
    USAGE
fi

if [ ! -d $SOURCE_DIR ]; then &>> $log_file
    echo -e "$R source $SOURCE_DIR does not exist$N" | tee -a $log_file
    exit 1
fi

if [ ! -d $DEST_DIR ]; then 
    echo -e "$R DEstination $DEST_DIR does not exist$N" | tee -a $log_file
    exit 1
fi

FILES=$(find $SOURCE_DIR -type f -name "*.log" -mtime +$DAYS) &>> $log_file

if [ ! -z "${FILES}" ]; then
    echo "FILES found $FILES" | tee -a $log_file
    TIMESTAMP=$(date +%F-%H-%M) &>> $log_file
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip" &>> $log_file
    echo "ZIP FILE NAME : $ZIP_FILE_NAME" | tee -a $log_file
   find $SOURCE_DIR  -name "*.log" -type f -mtime +$DAYS | zip -@ -j "$ZIP_FILE_NAME"

   if [ -f $ZIP_FILE_NAME ]; then
        echo -e "$G ARCHIVAL SUCCESS $N" | tee -a $log_file
        while IFS= read -r filepath
        do
            echo "deleting this file : $filepath" | tee -a $log_file
            rm -rf $filepath &>> $log_file
            echo "deleted the file $filepath" | tee -a $log_file
        done <<< $FILES
    else
        echo -e "$R ARCHIVAL FAILURE $N" | tee -a $log_file
        exit 1
    fi
else
    echo -e "no files to archieve  $YSKIPPING $N" | tee -a $log_file
fi
