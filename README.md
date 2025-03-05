# backup-script
Automated backup script using rsync

echo "# Backup Script

This script automates daily backups of critical system directories using **rsync**. It ensures that backups are stored on a remote TrueNAS server, organized by hostname and date.

## Features
- Uses **rsync** for efficient backups
- Creates a backup folder with hostname and date format (`hostname-YYYYMMDD`)
- Supports automated execution via **cron**
- Ensures remote directory exists before backup

## Installation
1. Clone the repository:
   \`\`\`
   git clone https://github.com/sya-one/backup-script.git
   \`\`\`
2. Make the script executable:
   \`\`\`
   chmod +x backup_script.sh
   \`\`\`
3. Set up SSH key-based authentication for passwordless execution.
4. Add the script to a **cron job** for automation.

## Usage
Run the script manually:
\`\`\`
./backup_script.sh
\`\`\`

Set up a **daily cron job**:
\`\`\`
0 1 * * * /path/to/backup_script.sh
\`\`\`

## Requirements
- Linux-based system (Ubuntu, Fedora, etc.)
- SSH access to the backup server
- `rsync` installed

## License
MIT License

## Author
**Siyabonga Chonco** - [Horsemen Technologies](https://www.horsementech.co.za)
" > README.md
