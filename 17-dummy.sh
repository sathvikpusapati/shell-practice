#!/bin/bash

id=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

log_folder="/var/log/shell-script"

log_name=$( echo $0 | cuut -d "." -f1)

log_file="$log_folder/log_name.log"

echo "script executed at : $(date)" | tee -a $LOG_FILE

if [ id -ne 0 ]; then
    echo  -e " $R ERROR :  PLEASE GIVE ROOT PRIVELLAGE FOR THE SCRIPT $N" | tee -a $log_file
    exit 1
fi

sudo mkdir -p $log_folder

VALIDATE()
{

    if [ $? -ne 0 ]; then
    echo  -e "  $2 INSTALLATION $R  FAILED  $N" | tee -a $log_file
    
    else
    echo  -e "  $2 INSTALLATION $G  SUCCESS  $N" | tee -a $log_file
    fi

}

dnf list installed mysql &>> log_file
 if [ $? -ne 0 ]; then

    dnf install mysql -y &>> log_file

    VALIDATE $? "MYSQL"
else

    echo -e "MYSQL INSTALLATION $Y.....SKIPPING$N" | tee -a $log_file
fi


dnf list installed nginx &>> log_file
 if [ $? -ne 0 ]; then

    dnf install nginx -y &>> log_file

    VALIDATE $? "NGINX"
else

    echo -e "NGINX INSTALLATION $Y.....SKIPPING$N" | tee -a $log_file
fi


dnf list installed python3 &>> log_file
 if [ $? -ne 0 ]; then

    dnf install python3 -y &>> log_file

    VALIDATE $? "python3"
else

    echo -e "python3 INSTALLATION $Y.....SKIPPING$N" | tee -a $log_file
fi

echo "script ended at : $(date)" | tee -a $LOG_FILE