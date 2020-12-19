#!/bin/bash


echo $1 - Time
echo $2 - Date


grep "$1" $2_Dealer_schedule | awk '{print $1, $2, $5, $6}'

# enter time with paranthesis ie "05:00:00 AM"
# enter date ie 0310

