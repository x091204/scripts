#!/bin/bash

# Load configuration file containing threshold values and defining colors to print in terminal
source "$(dirname "$0")/../config.cfg"
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Loop through each service defined inside config.cfg
# and Check if the current service is active using systemctl
for SERVICE in $SERVICES
do 
if systemctl is-active --quiet $SERVICE
then
    STATUS="${GREEN}PASS${NC}"
    PLAIN_STATUS="PASS"
else
    STATUS="${RED}ALERT${NC}"
    PLAIN_STATUS="ALERT"
fi

 # Print service status to terminal with color formatting
echo -e "Service: $SERVICE - $STATUS"

 # Generate timestamp for logging and  append service status result to centralized log file
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] SERVICE:$SERVICE $PLAIN_STATUS" >>  "$(dirname "$0")/../logs/health.log"


done
