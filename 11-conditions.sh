#!/bin/bash

echo "eneter a number"

read number 

if [ $(($number % 2)) -eq 0 ]; then

    echo "given  $number is even"
else

    echo "given $number is odd"

fi