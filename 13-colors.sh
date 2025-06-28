#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
   echo -e "$R ERROR:: Please run this script with root access $N"
   exit 1
else
   echo -e "You are running with root access"
fi

dnf install mysql-server -y

if [ $? -eq 0 ]
then
   echo -e "Installing MySQL is ... $G SUCCESS $N"
else
   echo -e "Installing MySQL is ... $R FAILURE $N"
   exit 1
fi


