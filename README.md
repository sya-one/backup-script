# Linux Rsync Backup Script

Simple and secure Linux backup script using `rsync` over SSH.

## Features

* Incremental backups using `rsync`
* SSH encrypted transfers
* Snapshot support
* Logging
* Error handling
* Easy cron scheduling
* Lightweight and fast

---

# Requirements

Install required packages:

```bash
sudo apt install rsync openssh-client
```

or on RHEL/CentOS:

```bash
sudo dnf install rsync openssh-clients
```

---

# Configuration

Edit the script variables:

```bash
SRC_DIRS=(
    "/etc"
    "/home"
    "/usr/local/scripts"
)

BACKUP_HOST="192.168.1.208"
BACKUP_BASE="/mnt/backups"
```

---

# SSH Key Setup

Generate SSH key:

```bash
ssh-keygen -t ed25519
```

Copy key to backup server:

```bash
ssh-copy-id user@192.168.1.208
```

Test connection:

```bash
ssh user@192.168.1.208
```

---

# Usage

Make the script executable:

```bash
chmod +x backup.sh
```

Run manually:

```bash
./backup.sh
```

---

# Cron Job

Run daily at 2 AM:

```cron
0 2 * * * /usr/local/bin/backup.sh
```

Edit cron jobs:

```bash
crontab -e
```

---

# Directory Structure

Example backup layout:

```text
/mnt/backups/
└── server01/
    ├── current/
    └── snapshots/
        ├── 20260528-020000/
        ├── 20260529-020000/
        └── 20260530-020000/
```

---

# Exclude File

Example exclusions:

```text
/proc
/sys
/dev
/tmp
/run
/mnt
/media
/lost+found
```

Add to rsync options:

```bash
--exclude-from=/etc/backup-excludes.txt
```

---

# Logs

Default log file:

```text
/var/log/backup-rsync.log
```

View logs:

```bash
tail -f /var/log/backup-rsync.log
```

---

# Restore Files

Restore a directory:

```bash
rsync -av backup-server:/mnt/backups/server01/current/etc /restore/location/
```

Restore a single file:

```bash
scp backup-server:/mnt/backups/server01/current/etc/hosts .
```

---

# Security Recommendations

* Use SSH keys instead of passwords
* Restrict SSH access
* Store backups on separate storage
* Test restores regularly
* Use firewall rules on backup server

---

# Future Improvements

* Retention cleanup
* Email notifications
* Compression tuning
* Backup verification
* Docker support
* ZFS snapshot integration
* Encryption with Borg or Restic

---

# License

MIT License
