#!/bin/bash

source ./01-common.sh

check_root

echo "Please enter DB Password"
read -s mysql_root_password

dnf install mysql-server-y &>>$LOGFILE
#VALIDATE $? "Installation of Mysql-server is success"

systemctl enable mysqld &>>$LOGFILE
#VALIDATE $? "Enabling mysql server"

systemctl start mysqld &>>$LOGFILE
#VALIDATE $? "Starting Mysql server"

#mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#VALIDATE $? "Setting up root password"

#below code will be useful for idemoptent nature 
mysql -h database.akshaydaws-78s.online -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
    #VALIDATE $? "MySQL Root password Setup"
else
    echo -e "MySQL Root password is already setup...$Y SKIPPING $N"
fi