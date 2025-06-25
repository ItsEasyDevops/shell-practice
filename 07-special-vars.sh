#!/bin/bash

echo "All variables passed to the script: $*"
echo "All variables passed to the script (as an array): $@"
echo "Number of arguments/variables passed to the script: $#"
echo "The name of the script: $0"
echo "The PID of the current script: $$"
echo "The PID of the last executed command: $!"
echo "Exit status of the last command: $?"
echo "Home directory of the current user: $HOME"
echo "Current working directory of the script: $PWD"
echo "Current user: $USER"
sleep 10 &
echo "PID of the last background command: $!"