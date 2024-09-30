#!/bin/bash

# Replace with the full path to the file you want to monitor
file_to_monitor="/home/lucien/Documents"

# Replace with the rclone command you want to execute
rclone_command="rclone sync 'Google Drive': '/home/lucien/Documents/Google Drive'"

# Use inotifywait to monitor the folder for changes
inotifywait -m -e modify,create,delete "$folder_to_monitor" | while read -r event file; do
  echo "Event: $event, File: $file"
  # Execute your rclone command here
  $rclone_command
done
