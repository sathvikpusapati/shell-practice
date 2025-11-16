#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

id=$(id -u)

folder="/var/log/shell-script"

name=$( echo $0 | cut -d "." -f1)

logfile=$folder/$name.log

sudo mkdir -p $folder 

if [ id -ne 0 ]; then
    echo -e "$R please give root access to continue$N" | tee -a $logfile
    exit 1
fi

USAGE(){

    echo "usage :: sudo sh backup.sh <source_dir> <destination_dir> <days>[optional, default 14 days] "
    exit 1
}

if [ $# -lt 2 ]; then
    USAGE
fi