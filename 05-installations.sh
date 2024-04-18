#!/bin/bash

USERID=$(id -u) #means userid is variable of id -u, id -u to know the user status

if [ $USERID -ne 0 ] #expression or condition to get the results
then 
echo "please run this script with root user"
exit 1 #manually exit if error comes
else
echo "your super user"
fi 

dnf install mysql -y

if [ $? -ne 0 ]
then
echo "please run with super user or install if MYSQL is failure"
exit 1
else
echo "installations of mysql is success"
fi

dnf install git -y

if [ $? -ne 0 ]
then 
echo "installtions of failure"
exit 1
else "installtions of git is sucess"
fi


