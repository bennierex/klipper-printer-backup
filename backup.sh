#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CONFIG_DIR="$DATA_PATH/config"
GIT_REMOTE_URL=$( git -C "$CONFIG_DIR" config --get remote.origin.url )
TIMESTAMP=$(date +'%Y-%m-%d %T')
LOGFILE="$HOME/config-backup.log"
{
  echo "Backing up $CONFIG_DIR to $GIT_REMOTE_URL"
  cd "$CONFIG_DIR"
  git add .
  git commit -m "Printer backup at $TIMESTAMP"
  git push -u origin master
} > "$LOGFILE" 2>&1
