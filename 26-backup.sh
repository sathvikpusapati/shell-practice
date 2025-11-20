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
folder="/var/log/shell-script"

name=$( echo $0 | cut -d "." -f1)

logfile=$folder/$name.log

sudo mkdir -p $folder 

if [ $id -ne 0 ]; then
    echo -e "$R please give root access to continue$N" | tee -a $logfile
    exit 1
fi

USAGE(){

    echo -e "$R usage :: sudo sh backup.sh <source_dir> <destination_dir> <days>[optional, default 14 days] " | tee -a $logfile
    exit 1
}

if [ $# -lt 2 ]; then &>> $logfile
    USAGE
fi

if [ ! -d $SOURCE_DIR ]; then &>> $logfile
    echo -e "$R source $SOURCE_DIR does not exist$N" | tee -a $logfile
    exit 1
fi

if [ ! -d $DEST_DIR ]; then 
    echo -e "$R DEstination $DEST_DIR does not exist$N" | tee -a $logfile
    exit 1
fi

FILES=$(find $SOURCE_DIR -type f -name "*.log" -mtime +$DAYS) &>> $logfile

if [ ! -z "${FILES}" ]; then
    echo "FILES found $FILES" | tee -a $logfile
    TIMESTAMP=$(date +%F-%H-%M) &>> $logfile
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip" &>> $logfile
    echo "ZIP FILE NAME : $ZIP_FILE_NAME" | tee -a $logfile
   find $SOURCE_DIR  -name "*.log" -type f -mtime +$DAYS | zip -@ -j "$ZIP_FILE_NAME"

   if [ -f $ZIP_FILE_NAME ]; then
        echo -e "$G ARCHIVAL SUCCESS $N" | tee -a $logfile
        while IFS= read -r filepath
        do
            echo "deleting this file : $filepath" | tee -a $logfile
            rm -rf $filepath &>> $logfile
            echo "deleted the file $filepath" | tee -a $logfile
        done <<< $FILES
    else
        echo -e "$R ARCHIVAL FAILURE $N" | tee -a $logfile
        exit 1
    fi
else
    echo -e "no files to archieve  $YSKIPPING $N" | tee -a $logfile
fi
