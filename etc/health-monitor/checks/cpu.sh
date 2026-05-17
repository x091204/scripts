#!/bin/bash

# Load configuration file containing threshold values
source "$(dirname "$0")/../config.cfg"

# Define terminal colors for output formatting
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Capture CPU usage percentage using top command
CPU_USAGE=$(top -bn1 |awk '/Cpu/ {print 100 - $8}')

# Compare CPU usage with configured threshold
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) ))
then
    STATUS="${RED}ALERT${NC}"
    PLAIN_STATUS="ALERT"
else
    STATUS="${GREEN}PASS${NC}"
    PLAIN_STATUS="PASS"
fi

# Display result in terminal
echo -e "CPU Usage: $CPU_USAGE% - $STATUS"

# Generate timestamp for logging and Append result to health log file
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] CPU $PLAIN_STATUS $CPU_USAGE%" >>  "$(dirname "$0")/../logs/health.log"
