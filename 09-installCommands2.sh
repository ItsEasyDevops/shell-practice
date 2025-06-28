#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
   echo "ERROR:: Please run this script with root access"
   exit 1
else
   echo "You're running with root access"
fi

dnf list installed MySQL

if [ $? -ne 0 ]
then 
    echo "MySQL is not installed.... Its about to be installed now!" 
    dnf install MySQL -y
else
    echo "MySQL is already installed... Nothing to do"
fi



