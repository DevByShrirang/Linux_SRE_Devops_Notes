#! /bin/bash

# directory to clean
CLEAN_DIR="/tmp/myapp"

#log file location
LOG_FILE="var/log/cleanup_temp.log"

#timestamp
TIMESTAMP= $(date "+%y-%m-%d %h-%m-%s")

#check if directroy exists
if [ -d "$CLEAN_DIR" ]; then
    echo "$TIMESTAMP -cleaning files older than 10 minutes in $CLEAN_DIR" >> "$LOG_FILE"
    find "$CLEAN_DIR" -type -f -mmin +10 -exec rm -f {} \; >> "$LOG_FILE" 2>&1
else
    echo  "$TIMESTAMP - Directory $CLEAN_DIR not found. " >> "$LOG_FILE"

    this bash script is used to check temporary directory. if present then it deletes files older than 10 minutes and log 
    the cleanup with timestamp to /var/log/cleanup_temp.log
    if the directory is not found this log also saved in log file.






 



    Must-Prepare Bash Script Scenarios for Today's Interview
🔢	Scenario	What They Want to See
1️⃣	Clean up old log/temp files	find, rm, date, file ops
2️⃣	Check service is running or not	Use of systemctl / ps + conditional
3️⃣	Disk usage check script	df, awk, threshold + alert
4️⃣	Backup files/directories	tar, scp, timestamped filenames
5️⃣	Monitor and restart crashed app	ps, grep, kill, nohup
6️⃣	Parse a log file and extract errors	grep, awk, cut, sed
7️⃣	Check if a port is open	netstat, lsof, or nc
8️⃣	Loop through servers and run command	for loop, ssh, expect
9️⃣	API health check script (curl)	curl, response code check
🔟	Trigger Jenkins job via API or CLI	curl with authentication or jenkins-cli

    