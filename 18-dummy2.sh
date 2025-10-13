#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "enter your name"

read user 

number=$(id -u)

script_name=$( echo $0 | cut -d "." -f1)

logs_folder="/var/log/shell-script"

logfile="$logs_folder/$script_name.log"

mkdir -p $logs_folder

name=sat

echo " script started at $(date) " | tee -a $logfile

if [ $number -ne 0 ]; then

    echo "PLEASE RUN SCRIPT WITH $R ROOT PRIVILLAGES $N" | tee -a $logfile
    exit 1


VALIDATE (){


    if [ $1 -ne 0 ]; then
    
        echo "$G $2 installed succesfully$N" | tee -a $logfile
    
    else
    
        echo "$R $2 not installed $N" | tee -a $logfile
    
    fi
}

dnf list installed mysql &>> $logfile

if [ $? -ne 0 ]; then 

    dnf install mysql-server -y &>> $logfile
    VALIDATE $? "MYSQL"


else

    echo "MYSQL is already installed $Y......skipping installation$N" | tee -a $logfile


fi

dnf list installed nginx &>> $logfile

if [ $? -ne 0 ]; then

    dnf install nginx -y &>> $logfile
    VALIDATE $? "NGINX"
else

    echo "NGINX is already installed $Y.....skipping installation$N" | tee -a $logfile
fi

dnf list installed nodejs &>> $logfile

if [ $? -ne 0 ]; then

    dnf install nodejs -y &>> $logfile
    VALIDATE $? "NODEJS"
else
 
    echo "NODEJS is already installed $Y ......skipping installation$N" | tee -a $logfile
fi

echo "environment variable owner name is $name" | tee -a $logfile

echo "SCript ended at $(date) " | tee -a $logfile 