#!/bin/bash

COURSE="Devops from current script"

echo "Before calling other script: $COURSE"
echo "Process ID of current script: $$"

./16-other-script.sh

echo "After calling other script: $COURSE"
echo "Process ID of current script: $$"

