```bash
#!/usr/bin/env bash

set -Eeuo pipefail

# ============================================
# Backup Configuration
# ============================================

# Directories to back up
SRC_DIRS=(
    "/etc"
    "/home"
    "/usr/local/scripts"
)

# Remote backup server
BACKUP_HOST="192.168.1.208"
BACKUP_BASE="/mnt/backups"

# Hostname-based backup directory
HOSTNAME="$(hostname -s)"
DATE="$(date +%Y%m%d-%H%M%S)"

# Current backup destination
DESTINATION="${BACKUP_HOST}:${BACKUP_BASE}/${HOSTNAME}/current"

# Optional snapshot directory
SNAPSHOT_DIR="${BACKUP_HOST}:${BACKUP_BASE}/${HOSTNAME}/snapshots/${DATE}"

# Log file
LOG_FILE="/var/log/backup-rsync.log"

# SSH options
SSH_OPTS="-o BatchMode=yes -o ConnectTimeout=10"

# rsync options
RSYNC_OPTS=(
    -a
    -v
    -h
    --delete
    --stats
    --partial
    --compress
)

# ============================================
# Functions
# ============================================

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

cleanup() {
    log "Backup script terminated unexpectedly."
}

trap cleanup ERR

# ============================================
# Pre-flight Checks
# ============================================

if ! command -v rsync >/dev/null 2>&1; then
    echo "ERROR: rsync is not installed."
    exit 1
fi

if ! ping -c 1 "$BACKUP_HOST" >/dev/null 2>&1; then
    echo "ERROR: Backup host unreachable: $BACKUP_HOST"
    exit 1
fi

log "Backup started."

# ============================================
# Run Backups
# ============================================

for DIR in "${SRC_DIRS[@]}"; do

    if [[ ! -d "$DIR" ]]; then
        log "WARNING: Directory not found: $DIR"
        continue
    fi

    log "Backing up $DIR"

    rsync \
        "${RSYNC_OPTS[@]}" \
        -e "ssh ${SSH_OPTS}" \
        "$DIR" \
        "$DESTINATION"

done

# ============================================
# Optional Snapshot Rotation
# ============================================

# Create dated snapshot from current backup
ssh ${SSH_OPTS} "$BACKUP_HOST" \
    "cp -al ${BACKUP_BASE}/${HOSTNAME}/current ${BACKUP_BASE}/${HOSTNAME}/snapshots/${DATE}" \
    >> "$LOG_FILE" 2>&1 || true

log "Backup completed successfully."
```
