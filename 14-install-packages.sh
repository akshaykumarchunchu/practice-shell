#!\bin\bash

USERID=$(id -u)
if [ $USERID -ne 0 ]
then 
	echo "Install the script with root user"
	exit 1                          
else
	echo "Your a super user"
fi

for i $0
do 
echo "package install $i"
done