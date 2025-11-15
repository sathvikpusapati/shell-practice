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

echo "SCRIPT EXECUTED AT $(date +%s) "