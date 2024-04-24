#!/bin/bash

# Check if a file is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 counts"
    exit 1
fi

# Read file and count words
cat $1 | tr -s '[:space:]' '\n' | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -nr | head -5