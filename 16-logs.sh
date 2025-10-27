
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
number=$(id -u)

if [ $number -ne 0 ]; then

    echo "ERROR : provide root privalages to run the script"
    exit 1
fi

mkdir -p $LOGS_FOLDER # by using p if already installed it stays calm doesnt throws any error
echo "script executed at : $(date)" | tee -a $LOG_FILE
VALIDATE() {

    if [ $1 -ne 0 ]; then

        echo -e "ERROR : $2 installation is $R... FAILURE$N" | tee -a $LOG_FILE

    else

        echo -e "$2 installation is $G...... SUCCESS$N" | tee -a $LOG_FILE

    fi
}

dnf list installed mysql &>> $LOG_FILE

if [ $? -ne 0 ];then
    dnf install mysql -y &>> $LOG_FILE
    VALIDATE $? "MYSQL"
else

    echo -e "MYSQL already exist $Y.....SKIPPING $N"
fi

dnf list installed nodejs &>> $LOG_FILE

if [ $? -ne 0 ];then
    dnf install nodejs -y &>> $LOG_FILE
    VALIDATE $? "NODEJS"
else

    echo -e "NODEJS already exist $Y.....SKIPPING $N"
fi

dnf list installed nginx &>> $LOG_FILE

if [ $? -ne 0 ];then
    dnf install nginx -y &>> $LOG_FILE
    VALIDATE $? "NGINX"
else

    echo -e "NGINX already exist $Y.....SKIPPING $N"
fi
