#!/bin/bash

USERID=$(id -u)
TEMPSTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOGFILE=/tmp/$SCRIPT_NAME-TEMPSTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
echo "Please enter DB Password"
read -s mysql_root_password

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

mkdir -p /app &>>$LOGFILE
VALIDATE $? "Creating directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading the code"

cd /app
unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE $? "Extract the zip file"

npm install &>>$LOGFILE
VALIDATE $? "Install nodejs dependencies"

cp /home/ec2-user/practice-shell/backend.service /ect/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "Copy backend-services"

systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "Daemon-reload"

systemctl start backend &>>$LOGFILE
VALIDATE $? "Start backend-services"

systemctl enable backend &>>$LOGFILE
VALIDATE $? "Enabling backend-services"

dnf install mysql -y &>>$LOGFILE
VALIDATE $? "Installing mysql services"

mysql -h database.akshaydaws-78s.online -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "Schema Loading"

Systemctl restart backend &>>$LOGFILE
VALIDATE $? "Restarting Backend"


