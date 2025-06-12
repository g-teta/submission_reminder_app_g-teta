#!/bin/bash

# Ask for the student's name
echo "Enter your name:"
read yourName
dirName="submission_reminder_${yourName}"

# Create the directory structure
mkdir -p "$dirName/app"
mkdir -p "$dirName/modules"
mkdir -p "$dirName/assets"
mkdir -p "$dirName/config"

# Populate app/reminder.sh
cat > "$dirName/app/reminder.sh" <<EOF
#!/bin/bash

# Source environment variables and helper functions
source "\$(dirname "\$0")/../config/config.env"
source "\$(dirname "\$0")/../modules/functions.sh"

# Path to the submissions file
submissions_file="\$(dirname "\$0")/../assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "\$submissions_file"
EOF

# Populate modules/functions.sh
cat > "$dirName/modules/functions.sh" <<EOF
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=\$1
    echo "Checking submissions in \$submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=\$(echo "\$student" | xargs)
        assignment=\$(echo "\$assignment" | xargs)
        status=\$(echo "\$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "\$assignment" == "\$ASSIGNMENT" && "\$status" == "not submitted" ]]; then
            echo "Reminder: \$student has not submitted the \$ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "\$submissions_file") # Skip the header
}
EOF

# Populate assets/submissions.txt
cat > "$dirName/assets/submissions.txt" <<EOF
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Kami, Shell Navigation, not submitted
Meghan, shell Navigation, submitted 
Maellene, Shell Navigation, submitted
Chris, Shell Navigation, not submitted
Jospin, Shell Navigation, submitted
Pacifique, Shell Navigation, not submitted 
Francis, Shell Navigation, submitted
EOF

# Populate config/config.env
cat > "$dirName/config/config.env" <<EOF
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=5
EOF

# Create app/scripts/startup.sh
cat > "$dirName/startup.sh" <<'EOF'
#!/bin/bash
# Load config
source "$(dirname "$0")/../../config/config.env"
# Run the reminder script
bash "$(dirname "$0")/../reminder.sh"
EOF

# Make all .sh files executable
chmod +x "$dirName"/app/*.sh
chmod +x "$dirName"/modules/*.sh

# Completion message
echo "Environment created successfully in $dirName"


