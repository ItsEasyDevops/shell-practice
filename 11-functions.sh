#!/bin/bash

#Defining a function called add numbers
add_numbers() {
   local num1=$1
   local num2=$2

#Perform Addition
   local sum=$(($num1+$:num2))

#Output the result
   echo "The sum of $num1 and $num2 is: $sum"
}


