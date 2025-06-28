#!/bin/bash

for i in {1..10}
do
  echo $i
done

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[33m"

LOGS_FOLDER="var/log/shellscript_logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

PACKAGES=("mysql" "nginx" "python")

mkdir -p $LOGS_FOLDER
echo "Script started at $(date)" | tee -a $LOGFILE

if [ $USERID -ne 0 ]
then
   echo -e "$R ERROR:: Please run this script using root user. $N" | tee -a $LOGFILE
   exit 1
else
   echo -e "$G You're running with root access. $N" | tee -a $LOGFILE
   exit 0
fi


VALIDATE(){
  if [ $1 -eq 0 ]
  then
     echo -e "Installing $2 ... $G SUCCESS $N"
  else
     echo -e "Installing $2 ... $R FAILURE $N "
  fi
}

for package in ${PACKAGES[@]} 
do
  dnf list installed $package &>> $LOGFILE
  if [ $? -ne 0 ]
  then
     echo "$package is not installed ... Going to install it" | tee -a $LOGFILE
     dnf install $package -y  &>> $LOGFILE
     VALIDATE $? "$package"
  else
     echo "Nothing to do ... $Y $package is already installed $N" | tee -a $LOGFILE
  fi
done