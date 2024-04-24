#!/bin/bash

SOURCE_DIRECTORY=/tmp/app-logs

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0"

if[ -d SOURCE_DIRECTORY ]
then 
    echo "Source directory exists"
else
    echo "Make sure Source directory exists"
    exit 
fi      