#!/bin/bash

USERID=$(id -u)
LOG_FOLDER="$/var/log/shell-script"
LOG_FILE="$/var/log/shell-script/shell-script.log"

if [ $USERID -ne 0 ]; then
    echo "Please login using Root user"
    exit1
fi

mkdir -p $LOG_FOLDER

VALIDATE()
{
if [ $1 -ne 0 ]; then
    echo "$2 is Failed"
    exit 1
else
    echo "$2 is completed"
fi
}

dnf insatll nginx -y &>> $LOG_FILE
VALIDATE $1 "Nginx Installation"

dnf insatll mysql -y &>> $LOG_FILE
VALIDATE $1 "Nginx Installation"

dnf insatll nodejs -y &>> $LOG_FILE
VALIDATE $1 "Nginx Installation"

