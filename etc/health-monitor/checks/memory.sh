#!/bin/bash

# Load configuration file containing threshold values and defining colors
source "$(dirname "$0")/../config.cfg"
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Capture memory usage using free command
MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.1f", $3/$2 * 100}')

# Compare Memory usage with configured limit
if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) ))
then
    STATUS="${RED}ALERT${NC}"
    PLAIN_STATUS="ALERT"
else
    STATUS="${GREEN}PASS${NC}"
    PLAIN_STATUS="PASS"
fi

# Generate timestamp for logging
echo -e "Memory Usage: $MEMORY_USAGE% - $STATUS"

# Generate timestamp for logging and append result to health log file
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] MEMORY $PLAIN_STATUS $MEMORY_USAGE%" >>  "$(dirname "$0")/../logs/health.log"
