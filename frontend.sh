#!/bin/bash 

USERID=$(id -u)
TEMP_STAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TEMP_STAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "Please give frontend password"
read -s mysql_root_password

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2---- $R Failure $N"
        exit 1
    else
        echo -e "$2----$G Success $N"
    fi
}

if [ $USERID -ne 0 ]
then 
    echo "Please work with root user"
    exit 1
else    
    echo "You're a super user"
fi 

dnf install nginx -y &>>$LOGFILE
VALIDATE $? "Installing nginx"

systemctl enable nginx &>>$LOGFILE
VALIDATE $? "Enabling nginx"

systemctl start nginx &>>$LOGFILE
VALIDATE $? "Starting Nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
VALIDATE $? "Removing the exit content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading code"

cd /usr/share/nginx/html &>>$LOGFILE
unzip /tmp/frontend.zip
VALIDATE $? "Extracting the code"

cp /home/ec2-user/practice-shell/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATE $? "Coping Nginx"

systemctl restart nginx &>>$LOGFILE
VALIDATE $? "Restarting Nginx"





