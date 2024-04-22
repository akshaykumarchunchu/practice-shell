#!/bin/bash

USERID=$(id -u) #to know the user id number to install on root user
TIMESTAMP=$(date +%F-%H-%M-%S) #to know the date,time,month,hours,secs of creating the logfile
SCRIPT_NAME=$(echo $0 | cut -d "." -f1) #--> To cut the last name of script name after . and take first name
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log #---> to know where the tmp data is saved 

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0"

echo "Script started executing at: $TIMESTAMP"

VALIDATE(){                 #function syntax
if [ $1 -ne 0 ]             #$1 means variable 1 that is in "dnf install" VALIDATE $?
then 	
    echo -e "$2 ---  $R failure $N"   #$2 means variable 1 that is in "dnf install" "Install mysql"
    exit 1
else
	echo -e "$2 --- $G Success $N"
fi
}

if [ $USERID -ne 0 ]
then 
	echo "Install the script with root user"
	exit 1                          #manually exit if error comes.
else
	echo "Your a super user"
fi

dnf install mysql -y &>>$LOGFILE
VALIDATE $? "Install mysql"

dnf install git -y &>>$LOGFILE
VALIDATE $? "install git"

dnf install dockerr -y &>>$LOGFILE
VALIDATE $? "install docker"