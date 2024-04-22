#!/bin/bash

USERID=$(id -u) #to know the user id number to install on root user
TIME_STAMP=$(date +%F-%H-%M-%S) #to know the date,time,month,hours,secs of creating the logfile
SCRIPT_NAME=$(echo $0 | cut -d "." -f) #--> To cut the last name of script name after . and take 
first name
LOGFILE=/tmp/$SCRIPT_NAME-$TIME_STAMP/log #---> to know where the tmp data is saved 

VALIDATE(){  #function syntax
if [ $1 -ne 0 ]         #$1 means variable 1 that is in "dnf install" VALIDATE $?
then 	
    echo "$2 --- failure" #$2 means variable 1 that is in "dnf install" "Install mysql"
    exit
else
	echo "$2 --- Success"
fi

if [ $USERID -ne 0 ]
then 
	echo "Install the script with root user"
	exit 1
else
	echo "Your a super user"
f1

dnf install mysql -y &>>$LOGFILE
VALIDATE $? "Install mysql"

dnf install git -y &>>$LOGFILE
VALIDATE $? "install git"