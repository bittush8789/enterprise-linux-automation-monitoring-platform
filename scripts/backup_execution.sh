#!/bin/bash
# Backup Execution Script

SOURCE_DIR=$1
S3_BUCKET=$2

if [ -z "$SOURCE_DIR" ] || [ -z "$S3_BUCKET" ]; then
    echo "Usage: $0 <source_directory> <s3_bucket>"
    exit 1
fi

TIMESTAMP=$(date +%Y%m%d%H%M%S)
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"
BACKUP_PATH="/tmp/${BACKUP_NAME}"

echo "Creating backup of $SOURCE_DIR..."
tar -czf "$BACKUP_PATH" "$SOURCE_DIR"

if [ $? -eq 0 ]; then
    echo "Backup created successfully at $BACKUP_PATH"
    echo "Uploading to S3..."
    aws s3 cp "$BACKUP_PATH" "s3://${S3_BUCKET}/${BACKUP_NAME}"
    
    if [ $? -eq 0 ]; then
        echo "Backup uploaded successfully."
        rm "$BACKUP_PATH"
    else
        echo "Failed to upload to S3."
        exit 1
    fi
else
    echo "Failed to create backup."
    exit 1
fi
