#!/bin/baash

number=$(id -u)

if [ $number -ne 0 ]; then

    echo "ERROR : provide root privalages to run the script"
    exit 1
fi

VALIDATE() {

    if [ $1 -ne 0 ]; then

        echo "ERROR : $2 installation is FAILURE"

    else

        echo "$2 installation is SUCCESS"

    fi
}

dnf install mysql -y
VALIDATE $? "MYSQL"

dnf install nodejs -y
VALIDATE $? "NODEJS"

dnf install nginx -y
VALIDATE $? "NGINX"
