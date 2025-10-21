1) how would you approach **Disk full** issue in linux?
--> Need to identify whats taking space and freeing the disk space.
df command to check oversll disk space
du -sh*  to find directories consuming most of the space.

locate unnecessary file- use command like find to locate old and unnecessary files such as logs or temporary files.
clear cache and temporary files- using appropriate command and tool
evaluate log files-  consider implementing log rotation if its not already in place.
uninstall unneeded software or package.
check for core dumps that can be deleted.
verify trash - empty the users trash bin if necessary.
expand disk if necessary- consider expanding the disk or partition if the issue recurs frequently.

2) explain the steps you's take to troubleshoot a **network connectivity issue** on linux server.
-->> start to verify physical connection.
2) to check network configuration using ifconfig or ip addr
3) to check network interface is up and has correct internet protocol address
4) Test connectivity to the local network with ping and inspect routing with route -n or ip route.
5) verify the domain name system (DNS) configuration in /etc/resolv.conf and test DNS resolution.
6) if firewall is present (security group, NACL )  review the rules to ensure its not blocking the necessary traffic.
7) Analyze the output of netstat command to reveal potential issues with listening port.
8) Review system and network logs found in /var/log which might give clues to specific issues.

3) How to check **status of service** on linux.?

use systemctl status [servicename] to check whether service is running or not.
if not running then use systemctl restart [servicename] 
again run systemctl status [servicename] to ensure service is active and running properly.
if we want the service to start automatically at boot  use systemctl enable [servicename]

4) what is the reason for suddenspike in **CPU utilization** ? how would you identify the culprit process?
several many reason for sudden spike in CPU
1) application load
2) Background tasks
3) Memory pressure
4) System level issue
5) security issue

See cpu spikes in real time
top -o %CPU
look for processes at the top
%CPU tells how much one process is consuming
press 1 to see per-core usage

investigate which process
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head

Monitor over time
mpstat -P ALL 1
shows  per-core CPU usage every 1 second.

check load average - uptime -High load average with low CPU usage = I/O wait or memory bottleneck
check process details - pidstat -p <pid> 1

5) Diagnosis of **slow server** response time?
Monitor system resource - use top or htop to monitor cpu and memory usage.
analyse disk input/output(i/o) - use iostat to check disk i/o is bottleneck
inspect network traffic - use iftop or nethogs to examine network traffic and look for unusual acitivities.
check load average - uptime -High load average with low CPU usage = I/O wait or memory bottleneck
Evaluate running processes- use ps with proper flags ana analyse running processes.
Review logs - inspect log files in /var/log for each messages or warnings.
profile application- if an application is slow use profiling tools specific to the application or language

6) how would you trobleshoot situation where **user cannot login** into liniux system
--> verify the users username and password . ensure the user is using correct credintials.
    check if the user account is loacked . use the passswd -s username command to see the account status.
    inspect the permission of users home directory. the permission must alllow the user to read and write.
    Examine system logs . look at the  /var/log/auth.log file for error messages related to login issue.
    if you are using SSH  for remote login , check the ssh configuration file for any restrictions on the users access.

7) Intermittent **SSH connection failures** , and how would you investigate them?
--> Many reasons for SSH connection failures.
1) Network issue
2) Server overload
3) configuration errors

check the network - verify the network connection between client and server is stable. use ping to check server is reachable.
examine the server load - use commands top to monitor server performance.
Look at SSH configuration-check the ssh configuration file /etc/ssh/sshd_config for any incorrect setting that might be causing the failure
Review the logs - inspect the servers SSH log files , usualy found in /var/log/auth.log for specific error messages

8) How can you determine if specific port is open and reachable on remote linux server?
--> To check if specific port is open and reachable on remote linux server you woud use tools like telnet, nc(netcat) or nmap.
you can check if the port is reachable by running commands like telnet hostname portnumber or nc -zv hostname portnumber.

9) Concept of file permission on linux system ,describe how incorrect permission  can lead to issue? 
--> file permission governs who can read, write and execute file. three types of permission
user(owner)   group other -- check using ls -l and modified using chmod
chmod and chown are linux commands used for managing files and directories.
chmod changes the file permission (read write execute) for owner, group and others
chown changes the file owner and group.

10 ) Importance of **log files** in troubleshooting?
Log files records system activities and errors.
Tracking errors- Log files record failure and issues, helping diagnose issues.
security monitoring - they help monitor unauthorized access attempts.
some important log files on linux system include
var/log/syslog - general system activities and logs
var/log/auth.log -  authentication logs , including successful and failed atttempts.
/var/log/kern.log- kernel logs , which are helpful in diagnosing hardware related problems.
/var/log/dmesg - boot and kernel messages.

11). How do you troubleshoot high CPU usage on a Linux server?
What they’re testing: OS-level diagnostic skills, familiarity with Linux tools.
First, I run **top/htop** to identify the process consuming the most CPU. Then I use 
**ps aux --sort=-%cpu | head -n 10** - this command will show top 10 processes by CPU usages
**less /var/log/syslog** / **less /var/log/messages** to check logs



What is the use of SSH?

--> SSH- called as secure shell. SSH is administrative protocol used to connect and manage remote servers over the internet. SSH is secured encrypted version
     of the previous known telnet which was unencrypted and not secure. SSH ensures that the communication with the remote server occurs in encrypted format.







