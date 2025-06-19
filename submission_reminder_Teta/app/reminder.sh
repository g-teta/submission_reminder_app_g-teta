#!/bin/bash

# Determine the script's parent directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

# Source environment variables and helper functions using full paths
source "$BASE_DIR/config/config.env"
source "$BASE_DIR/modules/functions.sh"

# Path to the submissions file
submissions_file="$BASE_DIR/assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"

