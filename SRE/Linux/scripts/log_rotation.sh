#!/bin/bash

# Configuration
LOG_DIR="/var/log/myapp"
ARCHIVE_DIR="$LOG_DIR/archive"
ROTATION_LOG="/var/log/log_rotation_status.log"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Ensure archive directory exists
mkdir -p "$ARCHIVE_DIR"

# Rotate and compress logs older than 1 day (excluding already compressed)
find "$LOG_DIR" -maxdepth 1 -type f -name "*.log" -mtime +1 ! -name "*.gz" | while read log_file; do
    base_name=$(basename "$log_file")
    new_name="${base_name%.log}-$TIMESTAMP.log.gz"
    
    # Compress and move to archive
    gzip -c "$log_file" > "$ARCHIVE_DIR/$new_name"
    echo "$TIMESTAMP - Rotated and archived $log_file to $ARCHIVE_DIR/$new_name" >> "$ROTATION_LOG"

    # Delete the original log
    rm -f "$log_file"
done

# Delete compressed logs older than 7 days
find "$ARCHIVE_DIR" -type f -name "*.gz" -mtime +7 -exec rm -f {} \; -exec echo "$TIMESTAMP - Deleted old archived log: {}" >> "$ROTATION_LOG" \;

echo "$TIMESTAMP - Log rotation completed." >> "$ROTATION_LOG"
