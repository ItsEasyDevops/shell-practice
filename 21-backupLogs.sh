#!/bin/bash

mkdir -p /app-logs
touch -d "15 days ago" /app-logs/cart.log
touch -d "15 days ago" /app-logs/user.log
touch -d "15 days ago" /app-logs/nginx.conf
touch -d "15 days ago" /app-logs/app.log
touch -d "15 days ago" /app-logs/cart.sh
touch -d "5 days ago" /app-logs/payment.log
touch -d "5 days ago" /app-logs/catalogue.log

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #If days are provided then given days are considered if not then by default it will take 14 days

LOGS_FOLDER="/var/log/shellscript-log"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

check_root
mkdir -p $LOGS_FOLDER


USAGE(){
     echo -e "$R USAGE: $N sh 20-backupLogs.sh <source-dir> <destination-dir> <days(optional)>"
}


if [ $# -lt 2 ]
then
    USAGE
fi


check_root(){
     if [ $USERID -ne 0 ]
     then
          echo -e "$R ERROR: Please run this script with root access $N" | tee -a $LOG_FILE
          exit 1
     else
          echo -e "$G You are running with root access $N" | tee -a $LOG_FILE
     fi
}

VALIDATE(){
    if [ $1 -eq 0 ]
    then
         echo -e "$2 is ... $G SUCCESS $N" | tee -a $LOG_FILE
    else
         echo -e "$2 is ... $R FAILURE $N" | tee -a $LOG_FILE
         exit 1
    fi
}

