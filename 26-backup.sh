#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

id=$(id -u)

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if not provided consider as 14 days
folder="/var/log/shell-script"

name=$( echo $0 | cut -d "." -f1)

logfile=$folder/$name.log

sudo mkdir -p $folder 

if [ id -ne 0 ]; then
    echo -e "$R please give root access to continue$N" | tee -a $logfile
    exit 1
fi

USAGE(){

    echo -e "$R usage :: sudo sh backup.sh <source_dir> <destination_dir> <days>[optional, default 14 days] "
    exit 1
}

if [ $# -lt 2 ]; then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]; then
    echo -e "$R source $SOURCE_DIR does not exist$N"
    exit 1
fi

if [ ! -d $DEST_DIR ]; then
    echo -e "$R DEstination $DEST_DIR does not exist$N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -type f -name "*.log" -mtime +$DAYS)

if [ ! -z "${FILES}" ]; then
    echo "FILES found $FILES"
    TIMESTAMP=$(date +%F-%H-%M)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    echo "ZIP FILE NAME : $ZIP_FILE_NAME"
   |find $SOURCE_DIR -type f -name "*.log" -mtime +$DAYS zip -@ -j "$ZIP_FILE_NAME"
else
    echo -e "files not found $YSKIPPING $N"
fi
