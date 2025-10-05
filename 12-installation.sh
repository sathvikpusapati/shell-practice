#!/bin/bash

number=$(id -u) #only root  user id is 0 so we are checking that

if [ $number -ne 0 ]; then

    echo "ERROR : please run with root access"
    exit 1 # othertahn 0 everything is failure
fi

dnf install mysql -y

if [ $? -eq 0 ]; then # $? exit status of last command is saved here if 0 success if 1 failure

    echo "mysql installation is succes"

else

    echo "ERROR : installation failed"
fi