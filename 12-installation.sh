#!/bin/bash

number=$(id -u)

if [ $number -ne 0 ]; then

    echo "ERROR : please reun with root access"
    exit 1 # othertahn 0 everything is failure
fi

dnf install mysql -y

if [ $? -eq 0 ]; then

    echo "mysql installation was succesful"

else

    echo "ERROR : installation failed"
fi