#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

id=$(id -u)

folder="/var/log/shell-script"

name=$( echo $0 | cut -d "." -f1)

logfile=$folder/$name.log

 mkdir -p $folder &>> $logfile

if [ id -ne 0 ]; then
    echo -e "$R please give root access to continue$N" | tee -a $logfile
    exit 1
fi

validate ()
{
    if [ $1 -ne 0 ]; then 
        echo -e "$R $2 installation failed $N" | tee -a $logfile
    else
        echo -e "$G $2 sucessfully installed $N" | tee -a $logfile
    fi
}

for package in $@ #here by using $@ we can send package names through argumments 
do
    # it will check whether the package is installed or not 

    dnf list installed $package $folder &>> $logfile
    
    if [ $? -ne 0 ]; then
        
        dnf install $package -y &>> $logfile

        validate $? "$package"

    else
        echo -e "$package already installed $Y skipping $N" | tee -a $logfile
    fi

done
