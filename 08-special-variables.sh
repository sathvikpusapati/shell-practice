#!/bin/bash

echo "all varaiables passed to this script $@"

echo "all varaiables passed to this script $*"

echo "script name : $0 "

echo "current directory : $PWD"

echo "who is running this : $USER"

echo "home directory of user : $HOME"

echo "pid of the script : $$"
sleep 50 &
echo "pid of the last command in background : $!"

