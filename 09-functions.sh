#!/bin/bash

USERID=$(id -u) #means userid is variable of id -u, id -u to know the user status

VALIDATE(){
    echo "Exit status: $1"
    echo "Exit status: $2"
}

if [ $USERID -ne 0 ] #expression or condition to get the results
then 
    echo "please run this script with root user"
    exit 1 #manually exit if error comes
else
    echo "your super user"
fi 

dnf install mysql -y
VALIDATE $? "Installing MYSQL" 
dnf install git -y
VALIDATE $? "Installing git"
