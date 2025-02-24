#!/bin/bash

source_directory=/tmp/app-logs

R="\e[31m"
G="\e[32m"
N="\e[0m"


if [ -d "$source_directory" ]; then
  echo -e"$G $source_directory exist $N"
  else 
  echo -e"$R please make sure $source_directory exist $N"
   exit 1
fi