#!/bin/bash

USERID=$( id -u )
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "please enter DB password"
read -s mysql_root_password

VALIDATE() {

    if [ $1 -ne 0 ]
    then 
        echo -e "$2..$R failure $N"
        exit 1
    else 
        echo -e "$2 ..$G success $N"
    fi

}

if [ $USERID -ne 0 ]
then 
    echo "please run this script with root access."
    exit 1
else 
    echo "you are super user."
fi

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "installing mysql server"

systemctl enable mysqld  &>>$LOGFILE
VALIDATE $? "enabling mysql server"

systemctl start mysqld  &>>$LOGFILE
VALIDATE $? "starting mysql server"

#mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#VALIDATE $? "setting up root password"

mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE

if [ $? -ne 0 ]
then 
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
    VALIDATE $? "setting up root root password"
else
    echo  -e "mysql root password is already setup ...$Y skipping $N"
fi
