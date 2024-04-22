#!/bin/bash

USERID=$(id -u) #means userid is variable of id -u, id -u to know the user status

VALIDATE(){
    if [ $1 -ne 0 ] 
    then
        echo "$2 is failure"
        exit 1
        else
        echo "$2 is success"
    fi    
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
