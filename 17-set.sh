#!/bin/bash

set -e 


Function_name(){
    echo "Failed at $1 : $2"
}

trap 'Function_name ${LINENO} "${BASH_COMMAND}"' ERR

USERID=$(id -u)
if [ $USERID -ne 0 ]
then 
    echo "Please run with super user"
    exit 1
else    
    echo "You're a super user"
fi

dnf install mysql-server -y &>>$LOGFILE
#VALIDATE $? "Installation of Mysql-server is success"

systemctl enable mysqld &>>$LOGFILE
#VALIDATE $? "Enabling mysql server"
