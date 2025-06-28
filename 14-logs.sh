#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript_logs"
SCRIPT_NAME= $(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "Script started at $(date)" | tee -a $LOG_FILE

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
   echo -e "$R ERROR:: Please run this script with root access $N" | tee -a $LOG_FILE
   exit 1
else
   echo -e "You are running with root access" | tee -a $LOG_FILE
fi

dnf install mysql-server -y &>> $LOG_FILE

if [ $? -eq 0 ]
then
   echo -e "Installing MySQL is ... $G SUCCESS $N" | tee -a $LOG_FILE
else
   echo -e "Installing MySQL is ... $R FAILURE $N" | tee -a $LOG_FILE
   exit 1
fi
