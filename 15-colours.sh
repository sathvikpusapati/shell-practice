#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

number=$(id -u)

if [ $number -ne 0 ]; then

    echo "ERROR : provide root privalages to run the script"
    exit 1
fi

VALIDATE() {

    if [ $1 -ne 0 ]; then

        echo "ERROR : $2 installation is $R... FAILURE$N"

    else

        echo "$2 installation is $G...... SUCCESS$N"

    fi
}

dnf list installed mysql

if [ $? -ne 0];then
    dnf install mysql -y
    VALIDATE $? "MYSQL"
else

    echo "MYSQL already exist $Y.....SKIPPING $N"
fi

dnf list installed nodejs

if [ $? -ne 0];then
    dnf install nodejs -y
    VALIDATE $? "NODEJS"
else

    echo "NODEJS already exist $Y.....SKIPPING $N"
fi

dnf list installed nginx

if [ $? -ne 0];then
    dnf install nginx -y
    VALIDATE $? "NGINX"
else

    echo "NGINX already exist $Y.....SKIPPING $N"
fi
