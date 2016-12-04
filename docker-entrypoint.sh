#!/bin/sh

echo "[$(date)] running rclone script"

# Check if rclone is already running
if pgrep -f rclone > /dev/null
then
  echo "[$(date)] rclone is already running"
  exit 0
else
  echo "[$(date)] rclone is not running, proceeding with script"
fi

# Run the rclone script
/usr/bin/rclone --config /config/.rclone.conf "$COMMAND"

# Add cron job and run the cron daemon
if [ -z "$1" ]
then
  echo "${CRON_STRING} /docker-entrypoint.sh 1 >> /dev/stdout" > /var/spool/cron/crontabs/root
  crond -l 10 -f
fi
