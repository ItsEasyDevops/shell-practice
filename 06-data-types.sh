#!/bin/bash

TIMESTAMP=$(date)           # () is to run it 
echo "Script executed at: $TIMESTAMP"

NUMBER1=100
NUMBER2=200

SUM=$(($NUMBER1+$NUMBER2))       # () Run the addition of number1 and number2; (()) assign the addition to the sum variable.
echo "The sum of $NUMBER1 and $NUMBER2 is: $SUM"
