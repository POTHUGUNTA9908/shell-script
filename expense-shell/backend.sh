# # #!/bin/bash

# # USERID=$( id -u )
# # TIMESTAMP=$(date +%F-%H-%M-%S)
# # SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
# # LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

# # R="\e[31m"
# # G="\e[32m"
# # Y="\e[33m"
# # N="\e[0m"

# # # echo "please enter DB password"
# # # read -s mysql_root_password

# # VALIDATE() {

# #     if [ $1 -ne 0 ]
# #     then 
# #         echo -e "$2..$R failure $N"
# #         exit 1
# #     else 
# #         echo -e "$2 ..$G success $N"
# #     fi

# # }

# # if [ $USERID -ne 0 ]
# # then 
# #     echo "please run this script with root access."
# #     exit 1
# # else 
# #     echo "you are super user."
# # fi

# # dnf module disable nodejs -y  &>>$LOGFILE
# # VALIDATE $? "Disabling default nodejs"


# # dnf module enable nodejs:20 -y &>>$LOGFILE
# # VALIDATE $? "Enabling  nodejs:20 version"

# # dnf install nodejs -y &>>$LOGFILE
# # VALIDATE $? "Installing nodejs "

# # id expense &>>$LOGFILE
# #  if [ $? -ne 0 ]
# # then
# #     useradd expense &>>$LOGFILE
# #     VALIDATE $? "creating expense user"
# # else
# #     echo -e "Expense user already created ...$Y skipping $N"
# # fi

# # mkdir -p /app &>>$LOGFILE
# # VALIDATE $? "creating /app directory"

# # curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
# # VALIDATE $? "downloading  backend code"

# # cd /app 
# # rm -rf /app/*
# # unzip /tmp/backend.zip &>>$LOGFILE
# # VALIDATE $? "Extracting backend code"



# # npm install &>>$LOGFILE
# # VALIDATE $? "installing node js dependencies"


# # cp /home/ec2-user/shell-script/expense-shell/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
# # VALIDATE $? "copied backend service"



# # dnf install mysql -y &>>$LOGFILE
# # VALIDATE $? "Installing MySQL Client"


# # mysql -h db.daws-78s.xyz -uroot -pExpenseApp@1  < /app/schema/backend.sql &>>$LOGFILE
# # VALIDATE $? "Schema loading"

# # systemctl daemon-reload &>>$LOGFILE
# # VALIDATE $? "Daemon reload"

# # systemctl start backend &>>$LOGFILE
# # VALIDATE $? "Starting backend"

# # systemctl enable backend &>>$LOGFILE
# # VALIDATE $? "Enabling backend"


# # systemctl Restart backend &>>$LOGFILE
# # VALIDATE $? "Restarting backend"

# #!/bin/bash
# LOGS_FOLDER="/var/log/expense"
# SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
# TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
# LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
# mkdir -p $LOGS_FOLDER
# USERID=$(id -u)
# R="\e[31m"
# G="\e[32m"
# N="\e[0m"
# Y="\e[33m"
# CHECK_ROOT(){
#     if [ $USERID -ne 0 ]
#     then
#         echo -e "$R Please run this script with root priveleges $N" | tee -a $LOG_FILE
#         exit 1
#     fi
# }
# VALIDATE(){
#     if [ $1 -ne 0 ]
#     then
#         echo -e "$2 is...$R FAILED $N"  | tee -a $LOG_FILE
#         exit 1
#     else
#         echo -e "$2 is... $G SUCCESS $N" | tee -a $LOG_FILE
#     fi
# }
# echo "Script started executing at: $(date)" | tee -a $LOG_FILE
# CHECK_ROOT
# dnf module disable nodejs -y &>>$LOG_FILE
# VALIDATE $? "Disable default nodejs"
# dnf module enable nodejs:20 -y &>>$LOG_FILE
# VALIDATE $? "Enable nodejs:20"
# dnf install nodejs -y &>>$LOG_FILE
# VALIDATE $? "Install nodejs"
# id expense &>>$LOG_FILE
# if [ $? -ne 0 ]
# then
#     echo -e "expense user not exists... $G Creating $N"
#     useradd expense &>>$LOG_FILE
#     VALIDATE $? "Creating expense user"
# else
#     echo -e "expense user already exists...$Y SKIPPING $N"
# fi
# mkdir -p /app
# VALIDATE $? "Creating /app folder"
# curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOG_FILE
# VALIDATE $? "Downloading backend application code"
# cd /app
# rm -rf /app/* # remove the existing code
# unzip /tmp/backend.zip &>>$LOG_FILE
# VALIDATE $? "Extracting backend application code"
# npm install &>>$LOG_FILE
#  cp /home/ec2-user/shell-script/expense-shell/backend.service /etc/systemd/system/backend.service &>>$LOGFILE

# #cp /home/ec2-user/expense-shell/backend.service /etc/systemd/system/backend.service
# # load the data before running backend
# dnf install mysql -y &>>$LOG_FILE
# VALIDATE $? "Installing MySQL Client"
# mysql -h db.daws-78s.xyz -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$LOG_FILE  #here mysql ip address or domain of mysql name
# VALIDATE $? "Schema loading"
# systemctl daemon-reload &>>$LOG_FILE
# VALIDATE $? "Daemon reload"
# systemctl enable backend &>>$LOG_FILE
# VALIDATE $? "Enabled backend"
# systemctl restart backend &>>$LOG_FILE
# VALIDATE $? "Restarted Backend"

#!/bin/bash
userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
Log_folder="/var/log/expense-logs"
[ ! -d "$Log_folder" ] && mkdir -p "$Log_folder"
logfile=$(basename $0 | cut -d "." -f 1)
timestamp=$(date '+%d-%m-%Y-%H-%M-%S')
logfilename="$Log_folder/$logfile-$timestamp.log"
validate(){
    if [ $1 -eq 0 ];
    then
        echo -e "$2 ...$G successfully $N"
    else
        echo -e "Error:: $2  .....$R failed $N"
        exit 1
    fi
}
CHECKROOT(){
    if [ $userid -ne 0 ];
    then
    echo "Error:: you must have sudo access to execute this script"
    exit 1
    fi
}
echo "script started executing at $timestamp" &>>$logfilename
CHECKROOT
dnf module disable nodejs -y &>>$logfilename
validate $? "disabling nodejs module"
dnf module enable nodejs:20 -y &>>$logfilename
validate $? "enabling nodejs module"
dnf install nodejs -y &>>$logfilename
validate $? "installing nodejs"
id expense &>>$logfilename
if [ $? -ne 0 ];then
    useradd expense
    validate $? "adding expense user"
else
    echo -e "user expense already exists..... $Y skipping $N"
fi
mkdir -p /app &>>$logfilename
validate $? "creating app directory"
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$logfilename
validate $? "downloading backend code"
cd /app
rm -rf /app/*
validate $? "cleaning app directory"
unzip /tmp/backend.zip &>>$logfilename
validate $? "unzipping  backend code"
npm install &>>$logfilename
validate $? "installing dependencies nodejs modules"
# cp /home/ec2-user/expense-shell/backend.service /etc/systemd/system/backend.service
 cp /home/ec2-user/shell-script/expense-shell/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
#preparing mysql schema
dnf install mysql -y &>>$logfilename
validate $? "installing mysql client"
mysql -h db.daws-78s.xyz -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$logfilename
validate $? "setting up the transaction schema and tables"
systemctl daemon-reload &>>$logfilename
validate $? "reloading daemon"
systemctl enable backend &>>$logfilename
validate $? "enabling backend"
systemctl restart backend &>>$logfilename
validate $? "starting backend"











