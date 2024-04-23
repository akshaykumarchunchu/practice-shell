#!/bin/bash

USERID=$(id -u)                             #to know the user id number to install on root user
TIMESTAMP=$(date +%F-%H-%M-%S)              #to know the date,time,month,hours,secs of creating the logfile
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)     #--> To cut the last name of script name after . and take first name
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log    #---> to know where the tmp data is saved 

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0"
echo "Please enter DB Password"
read -s mysql_root_password

VALIDATE(){                                 #function syntax
if [ $1 -ne 0 ]                             #$1 means variable 1 that is in "dnf install" VALIDATE $? Arguments
then 	
    echo "$2 --- failure"                   #$2 means variable 1 that is in "dnf install" "Install mysql"
    exit 1
else
	echo "$2 --- Success"
fi
}

if [ $USERID -ne 0 ]
then 
	echo "Install the script with root user"
	exit 1                          
else
	echo "Your a super user"
fi

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installation of Mysql-server is success"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting Mysql server"

#mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#VALIDATE $? "Setting up root password"

#below code will be useful for idemoptent nature 
mysql -h database.akshaydaws-78s.online -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
    VALIDATE $? "MySQL Root password Setup"
else
    echo -e "MySQL Root password is already setup...$Y SKIPPING $N"
fi