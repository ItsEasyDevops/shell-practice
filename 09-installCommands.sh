#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Error! Please run this script using root access"
    exit 1 #Giving status anything other than 0 upto 127
else
    echo "You're running with root access."
fi

dnf install mysql -y

if [ $? -eq 0 ]
then
   echo "mysql installation is successful"
else
   echo "mysql installation failed!"
   exit 1
fi