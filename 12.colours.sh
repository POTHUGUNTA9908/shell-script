 #!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
echo "script startyed executing at :$TIMESTAMP"

VALIDATE() {
    if [ $1 -ne 0 ]
    then 
        echo "$2...$R failure $N"
        exit 1
    else
        echo "$2...$G success $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access."
    exit 1 # manually exit if error comes.
else
    echo "You are super user."
fi

dnf install mysql -y &>>$LOGFILE

VALIDATE $? "Installing My SQL"

dnf install git -y &>>$LOGFILE

VALIDATE $? "Installing My git"

dnf install docker -y &>>$LOGFILE

VALIDATE $? "Installing My docker"
