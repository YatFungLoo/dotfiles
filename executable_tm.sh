#!/bin/bash

# Define color variables using ANSI escape codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get target time by adding seconds to current time
target_time=$(( $(date +%s) + $1 ))

while true; do
    current_time=$(date +%s)
    elapsed=$((current_time - target_time))  # Positive when overrun
    
    # Calculate absolute value for display, but keep sign for overrun indicator
    abs_seconds=$((elapsed < 0 ? -elapsed : elapsed))
    
    hours=$((abs_seconds / 3600))
    minutes=$(( (abs_seconds % 3600) / 60 ))
    seconds=$((abs_seconds % 60))
    
    if [ $elapsed -lt 0 ]; then
        # Counting down to target (negative elapsed)
        printf "  ${GREEN}elapsed${NC}: %02d:%02d:%02d\r" $hours $minutes $seconds
    else
        # Overrun - counting up past target (positive elapsed)
        printf "  ${RED}overran${NC}: %02d:%02d:%02d\r" $hours $minutes $seconds
    fi    

    sleep 1
done
