#!/bin/bash

# File to check
LOG_FILE="/var/log/syslog.1"
# Size threshold in bytes (1G = 1073741824 bytes)
THRESHOLD=1073741824
# Script to execute if condition is met
COMPRESS_SCRIPT="/path/to/compress_syslog.sh"

# Check if file exists
if [[ -f "$LOG_FILE" ]]; then
    # Get file size
    FILE_SIZE=$(stat -c%s "$LOG_FILE")

    if [[ $FILE_SIZE -gt $THRESHOLD ]]; then
        echo "File size is greater than 1G. Compressing..."
        bash "$COMPRESS_SCRIPT"
    else
        echo "File size is within limits. No action required."
    fi
else
    echo "Log file not found."
fi






============================================================


#!/bin/bash

# File to compress
LOG_FILE="/var/log/syslog.1"

# Check if file exists
if [[ -f "$LOG_FILE" ]]; then
    # Compress the file using gzip
    gzip "$LOG_FILE"
    echo "Compression complete: $LOG_FILE.gz"
else
    echo "Log file not found. No action taken."
fi
