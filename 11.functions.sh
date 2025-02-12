 #!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)

VALIDATE(){
    if [$1 -ne 0]
    then 
        echo "$2...failure"
        exit 1
    else
        echo "$2...success"
    fi

}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access."
    exit 1 # manually exit if error comes.
else
    echo "You are super user."
fi

dnf install mysql -y


VALIDATE $? "Installing My SQL"

dnf install git -y

VALIDATE $? "Installing My git"


