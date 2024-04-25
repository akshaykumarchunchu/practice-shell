#!/bin/bash 


source ./01-common.sh

check_root

echo "Please give frontend password"
read -s mysql_root_password

dnf install nginx -y &>>$LOGFILE
#VALIDATE $? "Installing nginx"

systemctl enable nginx &>>$LOGFILE
#VALIDATE $? "Enabling nginx"

systemctl start nginx &>>$LOGFILE
#VALIDATE $? "Starting Nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
#VALIDATE $? "Removing the exit content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
#VALIDATE $? "Downloading code"

cd /usr/share/nginx/html &>>$LOGFILE
unzip /tmp/frontend.zip
#VALIDATE $? "Extracting the code"

cp /home/ec2-user/practice-shell/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
#VALIDATE $? "Coping Nginx"

systemctl restart nginx &>>$LOGFILE
echo "Front installtations si done"
#VALIDATE $? "Restarting Nginx"





