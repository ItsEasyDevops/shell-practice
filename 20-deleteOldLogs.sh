#!/bin/bash

mkdir -p /app-logs
touch -d "15 days ago" /app-logs/cart.log
touch -d "15 days ago" /app-logs/user.log
touch -d "15 days ago" /app-logs/nginx.conf
touch -d "15 days ago" /app-logs/app.log
touch -d "15 days ago" /app-logs/cart.sh
touch -d "5 days ago" /app-logs/payment.log
touch -d "5 days ago" /app-logs/catalogue.log



USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SOURCE_DIR=/app-logs

mkdir -p $LOGS_FOLDER

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR: Please run this script with root access $N" | tee -a $LOG_FILE
    exit 1
else
    echo -e "$G You are running with root access $N" | tee -a $LOG_FILE
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
         echo -e "$2 is ... $G SUCCESS $N" | tee -a $LOG_FILE
    else
         echo -e "$2 is ... $R FAILURE $N" | tee -a $LOG_FILE
         exit 1
    fi

}


echo "Script started executing at $(date)"

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)

while IFS= read -r filepath
do
   echo "Deleting file: $filepath" | tee -a $LOG_FILE
   rm -rf $filepath
done <<< $FILES_TO_DELETE

echo "Script executed successfully"