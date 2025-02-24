# #!/bin/bash

# source_directory=/tmp/app-logs

# R="\e[31m"
# G="\e[32m"
# N="\e[0m"
# Y="\e[33m"


# if [ -d "$source_directory" ]
   echo -e"$G source directory exists $N"
# else 
#   echo -e "$R please make sure $source_directory exists $N"
#    exit 1
# fi

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