# submission_reminder_app_g-teta
This application helps remind students of their due assignments and notifies the professor on which students have submitted and those that have not submitted yet.

##How to set it up

1. To run the create_environment.sh script 
./create_environment.sh

#This will prompt you to enter your name 
Enter your name: 

#After entering your name, you will have created the directory
submission_reminder_yourName

2. To run the copilot_shell_script.sh 
./copilot_shell_script.sh

#This is going to prompt you to enter the Assignment name 
Assignment Name:

#The output is going to look similar to this 
Updated assignment name to 'Shell Basics' in ./submission_reminder_Teta/config/config.env
Looking for startup.sh at ./submission_reminder_Teta/startup.sh
Running startup.sh to check pending submissions for Shell Basics...
Starting Submission Reminder App
Assignment: Shell Basics
Days remaining to submit: 5 days
--------------------------------------------
Checking submissions in /root/submission_reminder_app_g-teta/submission_reminder_Teta/assets/submissions.txt
Reminder: Jospin has not submitted the Shell Basics assignment!
Reminder: Pacifique has not submitted the Shell Basics assignment!

#To add more students records or update them
use vi assets/submissions.txt 
#change the records in this order 
student, assignment, submissison status 
