#!/bin/bash

USERID=$(id -u)
TEMPSTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOGFILE=/tmp/$SCRIPT_NAME-TEMPSTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2....$R is failure $N"
        exit 1
    else
        echo -e "$2.... $G is success $N"
    fi 
}

if [ $USERID -ne 0 ]
then 
    echo "Please run with super user"
    exit 1
else    
    echo "You're a super user"
fi

dnf module disable nodejs -y &>>LOGFILE
VALIDATE $? "disabling default nodejs"

dnf module enable nodejs:20 -y &>>LOGFILE
VALIDATE $? "Enabling nodejs:20 version"

dnf install nodejs -y &>>LOGFILE
VALIDATE $? "Installating nodejs"

id expense &>>$LOGFILE
if [ $? -ne 0 ] 
then 
    useradd expense &>>$LOGFILE
    VALIDATE $? "Creating expense user"
else
    echo -e "Expense user already created..$Y Skipping $N"
fi
