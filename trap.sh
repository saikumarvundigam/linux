#!/bin/bash

set -e
trap 'echo" There is an errorn in $LINENO, command: $BASH_COMMAND"' ERR

USERID=$(id -u)
LOG_FOLDER="$/var/log/shell-script"
LOG_FILE="$/var/log/shell-script/shell-script.log"
R="\e[31m"
G="\e[32m"
B="\e[33m"
Y="\e[34m"
N="\e[0m"

if [ $USERID -ne 0 ]; then
    echo "$R Please login using Root user $N" | tee -a $LOG_FILE 
    exit1
fi

mkdir -p $LOG_FOLDER

for software in $@ # sudo sh loops.sh nginx mysql nodejs
do
dnf list installed $software
if [ $? -ne 0 ]; then
    echo "$software is not installed. Installing now"
    dnf install $software -y &>>$LOG_FILE # &>> to append the installatio output to logfile without overwritten
    VALIDATE $? "$software installation"
else
    echo"$software is already installed. Skipping the installation"
done

