# #!/bin/bash

#  source_directory=/tmp/app-logs

#  R="\e[31m"
#  G="\e[32m"
#  N="\e[0m"
#  Y="\e[33m"


#  if [ -d "$source_directory" ]
#     then
#    echo -e "$G source directory exists $N"
#   else 
#    echo -e "$R please make sure $source_directory exists $N"
#    exit 1
#  fi

# FILES=$(find $source_directory -name "*.log" -mtime +14)


# While IFS= read -r line
# do
#    echo "Deleting file: $line"
#    rm -rf $line
# done <<< $FILES


#!/bin/bash

SOURCE_DIRECTORY=/tmp/app-logs

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ -d $SOURCE_DIRECTORY ]
then
    echo -e "$G Source directory exists $N"
else
    echo -e "$R Please make sure $SOURCE_DIRECTORY exists $N"
    exit 1
fi

FILES=$(find $SOURCE_DIRECTORY -name "*.log" -mtime +14)

while IFS= read -r line
do
    echo "Deleting file: $line"
    rm -rf $line
done <<< $FILES