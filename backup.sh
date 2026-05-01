#!/usr/bin/env bash
set -u

SOURCE_DIR="$HOME/Documents/DashboardExports"
BACKUP_DIR="$HOME/dashboard-backups/backups"
CHECKSUM_DIR="$HOME/dashboard-backups/checksums"
LOG_FILE="$HOME/dashboard-backups/logs/backup.log"

log() {
    echo "$(date "+%Y-%m-%d %H:%M:%S") $1" >> "$LOG_FILE"
}

log "Backup Started"

mv ~/Downloads/JaysBakesLV_v4*.json "$SOURCE_DIR/" 2>/dev/null
mv ~/Downloads/finance-tracker-*.json "$SOURCE_DIR/" 2>/dev/null

for file in "$SOURCE_DIR"/*.json; do
    
    log "Checking $file"

    filename=$(basename "$file")
    current_hash=$(md5 -q "$file")
    checksum_file="$CHECKSUM_DIR/$filename.md5"
    stored_hash=$(cat "$checksum_file" 2>/dev/null)
    
    if [ "$current_hash" != "$stored_hash" ]; then
        mkdir -p "$BACKUP_DIR/$(date +%Y-%m-%d)/"
        cp "$file" "$BACKUP_DIR/$(date +%Y-%m-%d)/"
        echo "$current_hash" > "$checksum_file"
        log "$filename successfully backed up!"
    else
        log "Skipping $filename - no changes"
    fi

done

while [ $(ls -d "$BACKUP_DIR"/*/ 2>/dev/null | wc -l) -gt 3 ]; do
    oldest=$(ls -d "$BACKUP_DIR"/*/ 2>/dev/null | sort | head -1)
    rm -rf "$oldest"

    log "Deleted old backup: $oldest"
done

log "Backup Finished"





















