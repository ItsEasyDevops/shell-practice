#!/bin/bash

mkdir -p /source-dir
touch -d "15 days ago" /source-dir/cart.log
touch -d "15 days ago" /source-dir/user.log
touch -d "15 days ago" /source-dir/nginx.conf
touch -d "15 days ago" /source-dir/app.log
touch -d "15 days ago" /source-dir/cart.sh
touch -d "5 days ago" /source-dir/payment.log
touch -d "5 days ago" /source-dir/catalogue.log

mkdir -p /dest-dir

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


check_root
mkdir -p $LOGS_FOLDER


USAGE(){
     echo -e "$R USAGE: $N sh 20-backupLogs.sh <source-dir> <destination-dir> <days(optional)>"
}


if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d "$SOURCE_DIR" ]
then
    echo -e "$R ERROR: Source directory $SOURCE_DIR does not exist $N" | tee -a $LOG_FILE
    exit 1
fi

if [ ! -d "$DEST_DIR" ]
then
    echo -e "$Y Destination directory $DEST_DIR does not exist, creating it now... $N" | tee -a $LOG_FILE
fi

sudo install zip -y &>>$LOG_FILE

FILES=$(find $SOURCE_DIR -name "*.log" -mtime $DAYS)

if [! -z "$FILES" ]
then
    echo -e "$G Found log files to backup: $FILES $N" | tee -a $LOG_FILE
    ZIP_FILE="$DEST_DIR/backup-$(date +%Y%m%d).zip"
    echo $FILES | zip -@ $ZIP_FILE &>>$LOG_FILE
else
    echo -e "$Y No log files found to backup in $SOURCE_DIR $N" | tee -a $LOG_FILE
fi
