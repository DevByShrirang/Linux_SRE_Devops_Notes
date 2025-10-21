/var is almost 90 percent full, what will be your next steps

---> i will go to /var. then i will check which folder consuming more resources using command sudo du -sh *
using du -sh * i will get disk utilization of each folder.
I will delete old log files/archieve them.
create zip or tarzip.
remove cache using sudo apt clean.
Check if there is anything in /tmp folder.

2) Linux server is slow down due to high cpu utilization. how will you fix it?
---> first i wiil check using top/htop command
i will check which process consuming more cpu from all running processes.
if process is non-critical then kill the process
if process is important then depriotise it using nice/renice command.
depriortise will help to reduce cpu.

3) Application deployed on nginx returns connection refused,how will you fix it?
--> first i will check nginx service using sudo systemctl status nginx
then i will start the srvice using sudo systemctl start nginx
then i will check service status again.
I will check firewall, security group 

4) SSH to an instance stopped working? how will you trouleshoot the issue?

