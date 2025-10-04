#!/bin/bash 

NUMBER1=200

NUMBER2=100

NAME=sathvik

#even if we give wrong it wont throws an error
sum=$(($NUMBER1+$NUMBER2+$NAME))

echo "sum is $sum"

LEADERS=("putin" "modi" "obama" "trump")

echo "leaders are : ${LEADERS[@]}"

echo "leader at 1st index is : ${LEADERS[1]}"

echo "5th leader : ${LEADERS[6]}"
#it wont throw any out of bound error like other programs



