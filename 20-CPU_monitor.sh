#!/bin/bash

# Threshold for CPU usage (in percentage)
threshold=50

# Get the top 5 CPU-consuming processes
top_processes=$(ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6)

# Display the top 5 CPU-consuming processes
echo "Top 5 CPU-consuming processes:"
echo "$top_processes"

# Check if any process exceeds the threshold
while read -r line; do
    pid=$(echo "$line" | awk '{print $1}')
    cpu_usage=$(echo "$line" | awk '{print $4}')
    if (( $(echo "$cpu_usage > $threshold" | bc -l) )); then
        process_name=$(ps -p $pid -o comm=)
        echo "Alert: Process $process_name (PID: $pid) is consuming more than $threshold% of CPU."
        # Add your alerting mechanism here (e.g., send an email)
    fi
done <<< "$top_processes"