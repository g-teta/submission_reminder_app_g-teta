#!/bin/bash

# Change to the directory where this script is located
cd "$(dirname "$0")"

# Make all .sh files executable
find . -type f -name "*.sh" -exec chmod +x {} \;

echo "Starting Submission Reminder App"
bash "./app/reminder.sh"
