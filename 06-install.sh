USERID=$(id -u) #means userid is variable of id -u, id -u to know the user status

if [ $USERID -ne 0 ] #expression or condition to get the results
then 
echo "please run this script with root user"
exit 1 #manually exit if error comes
else
echo "your super user"
fi 