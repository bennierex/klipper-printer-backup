#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SERVICE_FILE="$SCRIPT_DIR/printerbackup.service"
ENV_FILE="$SCRIPT_DIR/klipper-printer-backup.env"
source <(sed -E -n 's/[^#]+/export &/ p' "$ENV_FILE")

# Make sure git is installed
hash git 2>/dev/null || { echo >&2 "Git is required. Please install first."; exit 1; }

# Make sure the data directory is where we expect it to be
[ -d "$DATA_PATH" ] || { echo >&2 "$DATA_PATH does not exist. Please make sure the correct path set in 'klipper-printer-backup.env'."; exit 1; }

chmod +x "$SCRIPT_DIR/backup.sh"
mkdir -p ~/.config/systemd/user
cp "$SERVICE_FILE" ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable printerbackup.service
