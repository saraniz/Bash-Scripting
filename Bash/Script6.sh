#!/bin/bash

LOG_FILE="system.log"

CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90

#while true mean this script run forever
while true; do

    # Timestamp
    time=$(date "+%Y-%m-%d %H:%M:%S")

    # top is A Linux command that shows real-time system usage Displays CPU, memory, processes, etc.
    # -b mean run in batch mode. -n1 → number of iterations -n = number of times to refresh, 1 = run only once
    # CPU usage

    # The awk command in your script:
    # Extracts the 8th field (the idle CPU %) 
    # Subtracts it from 100 to get the active CPU usage, Prints that value, which is then stored in the cpu variable.
    
    cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    cpu=${cpu%.*}

    # Memory usage
    mem=$(free | awk '/Mem/ {printf("%.0f"), $3/$2 * 100}')

    # Disk usage
    disk=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

    # Base output
    output="$time CPU: $cpu% MEM: $mem% DISK: $disk%"

    # Alerts
    if [ "$cpu" -gt "$CPU_THRESHOLD" ]; then
        output="$output WARNING: High CPU"
    fi

    if [ "$mem" -gt "$MEM_THRESHOLD" ]; then
        output="$output WARNING: High Memory"
    fi

    if [ "$disk" -gt "$DISK_THRESHOLD" ]; then
        output="$output WARNING: High Disk"
    fi

    # Print and log
    echo "$output"
    echo "$output" >> "$LOG_FILE"

    # Wait before next check
    sleep 5

done
