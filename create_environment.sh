#!/bin/bash

#ask for the students name 
echo "Enter your name"
read yourName
dirName="submission_reminder_${yourName}"

#Create the directory structure 
mkdir -p "$dirName/app"
mkdir -p "$dirName/modules"
mkdir -p "$dirName/assets"
mkdir -p "$dirName/config"

#populate app
touch $dirName/app reminder.sh
cat > "$dirName/app/reminder.sh" <<EOF 
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

#Populate functions.sh
touch $dirName/modules functions.sh 
cat > "$dirName/modules/functions.sh" <<EOF
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
#populate submissions.txt
touch $dirName/assets submissions.txt
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

#populate config.env
touch $dirName/config/config.env <<EOF
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=5

#create startup.sh
cat > "$app_dir/scripts/startup.sh" <<'EOF'
#!/bin/bash
#Load config 
source "$(dirname "$0")/../config/config.env"
# Run the reminder script
bash "$(dirname "$0")/reminder.sh
EOF

#Make all .sh executable 
chmod +x "$app_dir/scripts/"*.sh

echo "Environment created successfully in $app_dir"
echo "To start the application, run: bash
$app_dir/scripts/startup.sh"

