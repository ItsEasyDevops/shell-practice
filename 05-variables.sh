#!/bin/bash

echo "Enter your PIN number:"
read pin                       # read is to take the arguments during runtime but it shows what we have entered.
echo "You entered: $pin"
echo "Enter your PIN number again:"
read -s pin2                   # read -s is to take the arguments during runtime but it doesn't show what we have entered.
echo "You entered: $pin2"
