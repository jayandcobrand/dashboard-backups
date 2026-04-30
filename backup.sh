#!/usr/bin/env bash

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

find "$BACKUP_DIR" -maxdepth 1 -type d -mtime +3 | while read old_dir; do
    rm -rf "$old_dir"
    log "Deleted old backup: $old_dir"
done

log "Backup Finished"





















