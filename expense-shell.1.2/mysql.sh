#!/bin/bash

source ./common.sh

check_root


echo "please enter DB password"
read mysql_root_password

dnf install mysql-server -y &>>$LOGFILE
#VALIDATE $? "installing mysql server"

systemctl enable mysqld  &>>$LOGFILE
#VALIDATE $? "enabling mysql server"

systemctl start mysqld  &>>$LOGFILE
#VALIDATE $? "starting mysql server"

#mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#VALIDATE $? "setting up root password"

mysql -h db.daws-78s.xyz -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
else
    echo -e "MySQL Root password is already setup...$Y SKIPPING $N"
fi
