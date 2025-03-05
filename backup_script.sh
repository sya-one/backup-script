#!/bin/bash

# Directories to backup
SRC_DIRS=("/etc" "/home" "/usr/local/scripts")

# Destination on TrueNAS
DESTINATION="192.168.1.208:/mnt/backups/$(hostname)-$(date +%Y%m%d)"

# Destination on Open Media Vault
# DESTINATION="192.168.1.208:/export/backups/$(hostname)-$(date +%Y%m%d)"

# rsync options
RSYNC_OPTS="-avz --delete"

# Loop through directories and sync each one
for DIR in "${SRC_DIRS[@]}"; do
    rsync $RSYNC_OPTS "$DIR" "$DESTINATION"
done

echo "Backup completed at $(date)"
