#!/bin/bash

number=$1

if [ $number -lt 10 ]; then

    echo "given number $number is less tham 10"

elif [ $number -eq 10 ]; then

    echo "given nummber $number is equal to 10"

else

    echo "given number $number is greater than 10"
fi 