
#!/bin/bash


source ./common.sh

check_root()

echo "please enter DB password:"
read -s mysql_root_password

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "installing mysql server"

systemctl enable mysqld  &>>$LOGFILE
VALIDATE $? "enabling mysql server"

systemctl start mysqld  &>>$LOGFILE
VALIDATE $? "starting mysql server"

#mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#VALIDATE $? "setting up root password"

mysql_secure_installation --set-root-pass ${mysql_root_password} -e 'show databases;' &>>$LOGFILE

if [ $? -ne 0 ]
then 
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
    VALIDATE $? "setting up root root password"
else
    echo  -e "mysql root password is already setup ...$Y skipping $N"
fi