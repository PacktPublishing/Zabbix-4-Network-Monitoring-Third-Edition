#!/bin/bash

hostname="IT services"
time_period=$[3600*24*365] # 365 days
interval=3600 # one hour
probability=100

current_time=$(date "+%s")
for item_key in code_repo warehouse_analytics ticketing; do
    [[ -f $item_key.txt ]] && {
        echo "file $item_key.txt already exists"
        exit
    }
    for ((value_timestamp=$current_time-$time_period; value_timestamp<$current_time; value_timestamp=value_timestamp+$interval)); do
        echo "\"$hostname\" $item_key $value_timestamp $([[ $(($RANDOM%$probability)) < 1 ]] && echo 0 || echo 1)" >> $item_key.txt
    done
done
