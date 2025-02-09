#!/bin/bash


USERID=$(id-u)
if[$userid -ne 0]
then
  echo"please run this script with root access"
 else 
    echo"you are super user."
fi
