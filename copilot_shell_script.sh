#!/bin/bash

# Prompt for the new assignment name
read -p "Enter the new assignment name: " newAssignment

# Escape any double quotes from user input
escapedAssignment=$(echo "$newAssignment" | sed 's/"/\\"/g')

# Locate config.env and find the directory containing it
configPath=$(find . -type f -path "*/config/config.env" | head -n1)

if [[ -z "$configPath" ]]; then
    echo "config.env not found. Please run this script from the base directory."
    exit 1
fi

# Update the assignment value in config.env
sed -i.bak "s/^ASSIGNMENT=.*/ASSIGNMENT=\"${escapedAssignment}\"/" "$configPath"

echo "Updated assignment name to '$newAssignment' in $configPath"

# Determine the base directory of the project
baseDir=$(dirname "$(dirname "$configPath")")
startupScript="$baseDir/startup.sh"

echo "Looking for startup.sh at $startupScript"

# Check if startup.sh exists (file check only, not execute check)
if [[ -f "$startupScript" ]]; then
    echo "Running startup.sh to check pending submissions for $newAssignment..."
    bash "$startupScript"
else
    echo "startup.sh not found at $startupScript"
    exit 1
fi
