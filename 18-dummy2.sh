#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

script_name=$( echo $0 | cut -d "." -f1)
folder="/var/log/shell-script"

log="$folder/$script_name.log"



echo "script start time $(date)"

mkdir -p $folder

if [ "$(id -u)" -ne 0 ]; then

    echo -e "$R ERROR PLEASE GIVE ROOT PERMISSIONS $N" | tee -a $log
    exit 1
fi

VALIDATE()
{
    if [ $1 -eq 0 ]; then

        echo -e "$G $2 installation success $N" | tee -a $log
    else
        echo -e "$R $2 installation failed $N" | tee -a $log
    fi

}

dnf list installed mysql &>> $log

if [ $? -ne 0 ]; then

    dnf install mysql-server -y &>> $log
    VALIDATE $? "MYSQL"
else

    echo -e "$Y MYSQL ALREADY INSTALLED $N" | tee -a $log
fi

dnf list installed redis &>> $log

if [ $? -ne 0 ]; then

    dnf install redis -y &>> $log
    VALIDATE $? "REDIS"
else

    echo -e "$Y REDIS ALREADY INSTALLED $N" | tee -a $log
fi

dnf list installed nodejs &>> $log
 if [ $? -ne 0 ]; then

    dnf install nodejs -y &>> $log

    VALIDATE $? "nodejs"
else

    echo -e "$Y NODEJS ALREADY INSTALLED $N" | tee -a $log
fi

echo "SCRIPT END TIME $(date)" | tee -a $log

echo "log file will display after 5 seconds"

sleep 5

cat $log


