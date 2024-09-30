#!/bin/bash

# Replace with the full path to the file you want to monitor
file_to_monitor="/home/lucien/Documents/Google Drive"

# Replace with the rclone command you want to execute
rclone_command="rclone sync '/home/lucien/Documents/Google Drive' 'Google Drive':"

# Set the cooldown period in seconds (1 hour in this case)
cooldown_period=3600

# Variable to store the last execution time
last_execution_time=0

# Function to check if the cooldown period has elapsed
function cooldown_elapsed() {
    current_time=$(date +%s)
    if (( current_time - last_execution_time >= cooldown_period )); then
        return 0  # Cooldown has elapsed
    else
        return 1  # Cooldown has not elapsed
    fi
}

# Use inotifywait to monitor the folder for changes
inotifywait -m -r -e modify,create,delete,moved_to,moved_from "$folder_to_monitor" | while read -r event file; do
    echo "Event: $event, File: $file"

    # Check if the cooldown period has elapsed
    if cooldown_elapsed; then
        echo "Running rclone command: $rclone_command"
        $rclone_command
        last_execution_time=$(date +%s)
    else
        echo "Cooldown period not elapsed. Skipping rclone command."
    fi
done
