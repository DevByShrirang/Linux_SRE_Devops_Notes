Linux process troubleshooting command
ps aux - shows all running processes with detailed info. showing user, PID, cpu/memory usage, and command.
       ps aux | grep

top - Real time view of CPU, memory,load average and running processes.
Press P to sort by CPU, M by memory, k to kill a process by PID.

pidstat --> pidstat -p <PID> 1 - Monitor resource usage(CPU/ I/O) per process dynamically.
pmap --> pmap -x <PID> -- Detailed memory map of process.
pstree --> pstree -p    -- Displays processes in hierachical(tree) format.to view parent child relatioship between processes.
lsof --> lsof -p <PID>  --lsof -p :8080 --lists open files/sockets by processes.
ss -tulnp --shows all listening ports with associated processes.- To check which service is bound with which port.
strace -p <PID>  - Trace system calls made by process.
vmstat 2 5 --> display CPU, Memory, and I/O statistics every 2 sec (5 iterations)
iostat --> iostat -xz 2 - Monitor CPU or disk I/O usage
nice/renice - ren
dmesg |   tail  --> dmesg | tail -20 -- shows kernel level messages.(crashes, OOM kills, disk errors)

Zombie process:- A Zombie process is a process that has completed execution (it’s dead), but its entry still exists in the process table because its parent hasn’t read its exit status yet.
Zombie process not consuming CPU or memory but they occupy a PID slot
ps aux | grep Z

----------------------------------------------------------------------------------------------------------------------------------
**Top 10 Linux directories**

/etc/passwd -  Stores user account details (username, UID, GID, homeDir, shell)
/etc/shadow -  stores encrypted user passwords (root-readable only)
/etc/sudoers - Which user can execute command as root.
                To assign jenkins users limited root access. allowing them to restart service or deploy code without full 
                     admin privileges.
                     jenkins ALL(ALL) NOPASSWD: /bin/systemctl restart jenkins
/etc/hosts - static hostname 
/etc/resolve.conf - define DNS nameservers for name resolution.
/etc/fstab -  filesystem and mount points.
               used /etc/fstab while attaching EBS volumes to ec2 servers.
/var/log --  stores all system log -auth, kernel, application logs.
/etc/network/interfaces  -->   used for network configuration(ip, gateway,DNS)
/etc/netplan/*.yaml --> Ussed to configure static IPs for private EC2 servers and update network setting during VPN /VPC setting.
~/.bashrc & ~/.bash_profile --> used for setting up shell environment variable , alises and PATH.
                              have added custom env variables and PATH exports in .bashrc for tools like kubectl ,helm and terraform to make them globally available for the jenkins or EC2 server.

/etc/crontab --> define scheduled tasks.
/etc/systemd/system  --> manages services with systemd.
                         I wrote systemd unit to automatically start the docker daemon and jenkins service on ec2 reboot.