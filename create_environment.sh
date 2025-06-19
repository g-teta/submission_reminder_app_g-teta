#!/bin/bash 

#Prompt the user for their name 
read -p "Enter your name: " userName

#define the base directory 
baseDir="submission_reminder_${userName}"

#Create directory structure 
mkdir -p "$baseDir/app"
mkdir -p "$baseDir/modules"
mkdir -p "$baseDir/assets"
mkdir -p "$baseDir/config"

#Create the reminder.sh
cat > "$baseDir/app/reminder.sh" <<'EOF'
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

EOF

#Create functions.sh 
cat > "$baseDir/modules/functions.sh" <<'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

#Create Submissions.txt listing the students 
cat > "$baseDir/assets/submissions.txt" <<'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Jospin, Shell Basics, not submitted 
Meghane, Shell Basics, submitted 
kami, Shell basics, submitted
Pacifique, Shell Basics, not submitted
Precious, shell Basics, submitted
Luigi, git, not submitted
EOF

#create the config file 
cat > "$baseDir/config/config.env" <<'EOF'
#This is the config file
ASSIGNMENT="Shell Basics"
DAYS_REMAINING=5
EOF

#create the startup.sh script
cat > "$baseDir/startup.sh" <<'EOF'
#!/bin/bash

# Change to the directory where this script is located
cd "$(dirname "$0")"

# Make all .sh files executable
find . -type f -name "*.sh" -exec chmod +x {} \;

echo "Starting Submission Reminder App"
bash "./app/reminder.sh"
EOF

#make all .sh file executable 
chmod +x "$baseDir/startup.sh"
chmod +x "$baseDir/app/"*.sh

echo "$baseDir has been created"

