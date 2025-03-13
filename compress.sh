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



====================================================================

#!/bin/bash

# Define log files to check
LOG_FILES=(
    "/var/log/syslog.1"
    "/var/log/nginx/access.log.1"
)

# Size threshold in bytes (1G = 1073741824 bytes)
THRESHOLD=1073741824
# Script to execute if condition is met
COMPRESS_SCRIPT="/path/to/compress_log.sh"

for LOG_FILE in "${LOG_FILES[@]}"; do
    if [[ -f "$LOG_FILE" ]]; then
        FILE_SIZE=$(stat -c%s "$LOG_FILE")

        if [[ $FILE_SIZE -gt $THRESHOLD ]]; then
            echo "File $LOG_FILE is greater than 1G. Compressing..."
            bash "$COMPRESS_SCRIPT" "$LOG_FILE"
        else
            echo "File $LOG_FILE is within limits. No action required."
        fi
    else
        echo "File $LOG_FILE not found."
    fi
done






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
================================================================


#!/bin/bash

# Get the log file as an argument
LOG_FILE="$1"

# Check if argument is provided
if [[ -z "$LOG_FILE" ]]; then
    echo "No log file provided."
    exit 1
fi

# Check if file exists
if [[ -f "$LOG_FILE" ]]; then
    gzip "$LOG_FILE"
    echo "Compression complete: $LOG_FILE.gz"
else
    echo "Log file $LOG_FILE not found. No action taken."
fi
