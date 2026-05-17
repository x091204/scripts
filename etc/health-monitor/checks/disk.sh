#!/bin/bash

# Load configuration file containing threshold values
source "$(dirname "$0")/../config.cfg"

# Define terminal colors for output formatting
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Capture Disk usage using df command
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

# Compare Disk usage with configured limit
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]
then
    STATUS="${RED}ALERT${NC}"
    PLAIN_STATUS="ALERT"
else
    STATUS="${GREEN}PASS${NC}"
    PLAIN_STATUS="PASS"
fi

# Display result in terminal
echo -e "Disk Usage: $DISK_USAGE% - $STATUS"

# Generate timestamp for logging and append result to health log file
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] DISK $PLAIN_STATUS $DISK_USAGE%" >>  "$(dirname "$0")/../logs/health.log"
