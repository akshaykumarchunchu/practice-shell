#!/bin/bash

source ./01-common.sh

check_root

echo "Please enter backend Password"
read -s mysql_root_password

dnf module disable nodejs -y &>>$LOGFILE
#VALIDATE $? "disabling default nodejs"

dnf module enable nodejs:20 -y &>>$LOGFILE
#VALIDATE $? "Enabling nodejs:20 version"

dnf install nodejs -y &>>$LOGFILE
#VALIDATE $? "Installating nodejs"

id expense &>>$LOGFILE
if [ $? -ne 0 ] 
then 
    useradd expense &>>$LOGFILE
    #VALIDATE $? "Creating expense user"
else
    echo -e "Expense user already created..$Y Skipping $N"
fi

mkdir -p /app &>>$LOGFILE
#VALIDATE $? "Creating directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
#VALIDATE $? "Downloading the code"

cd /app
rm -rf /app/*
unzip /tmp/backend.zip &>>$LOGFILE
#VALIDATE $? "Extract the zip file"

npm install &>>$LOGFILE
#VALIDATE $? "Install nodejs dependencies"

cp /home/ec2-user/practice-shell/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
#VALIDATE $? "Copy backend-services"

systemctl daemon-reload &>>$LOGFILE
#VALIDATE $? "Daemon-reload"

systemctl start backend &>>$LOGFILE
#VALIDATE $? "Start backend-services"

systemctl enable backend &>>$LOGFILE
#VALIDATE $? "Enabling backend-services"

dnf install mysql -y &>>$LOGFILE
#VALIDATE $? "Installing mysql services"

mysql -h database.akshaydaws-78s.online -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE
#VALIDATE $? "Schema Loading"

systemctl rrestart backend &>>$LOGFILE
echo "Task compeleted"
#VALIDATE $? "Restarting Backend"


