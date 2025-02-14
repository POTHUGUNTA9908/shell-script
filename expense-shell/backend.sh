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

dnf module disable nodejs -y  &>>$LOGFILE
VALIDATE $? "Disabling default nodejs"


dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATE $? "Enabling  nodejs:20 version"

dnf install nodejs -y &>>$LOGFILE
VALIDATE $? "Installing nodejs "

id expense &>>$LOGFILE
 if [ $? -ne 0 ]
then
    useradd expense &>>$LOGFILE
    VALIDATE $? "creating expense user"
else
    echo -e "Expense user already created ...$Y skipping $N"
fi

mkdir -p /app &>>$LOGFILE
VALIDATE $? "creating /app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
VALIDATE $? "downloading  backend code"

cd /app 
rm -rf /app/*
unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE $? "Extracting backend code"



npm install &>>$LOGFILE
VALIDATE $? "installing node js dependencies"


cp /home/ec2-user/shell-script/expense-shell/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "copied backend service"

systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "Daemon reload"

systemctl start backend &>>$LOGFILE
VALIDATE $? "Starting backend"

systemctl enable backend &>>$LOGFILE
VALIDATE $? "Enabling backend"

dnf install mysql -y &>>$LOGFILE
VALIDATE $? "Installing mysql client"


mysql -h db.daws-78s.xyz  -uroot -p${mysql_root_password}  < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $?> "Schema loading"

systemctl restart backend &>>$LOGFILE
VALIDATE $? "Restarting backend"

