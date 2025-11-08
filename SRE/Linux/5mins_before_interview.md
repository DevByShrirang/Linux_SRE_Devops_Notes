Linux process troubleshooting command
ps aux - shows all running processes with detailed info. showing user, PID, cpu/memory usage, and command.
       ps aux | grep

top - Real time view of CPU, memory,load average and running processes.
Press P to sort by CPU, M by memory, k to kill a process by PID.

pidstat --> pidstat -p <PID> 1 - Monitor resource usage(CPU/ I/O) per process dynamically.
pmap --> pmap -x <PID> -- Detailed memory map of process.
pstree --> pstree -p    -- Displays processes in hierachical(tree) format.to view parent child relatioship between processes.
lsof --> lsof -p <PID>  --lsof -p :8080 --lists open files/sockets by processes.
netstat -tulpn | grep <port_number> - To check which process using perticular port.
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

----------------------------------------------------------------------------------------------------------------------------------

useradd   adduser

Both commands are used to create user accounts in Linux, but there’s a key difference in how they work internally.

useradd is a low-level binary provided by the shadow-utils package. It creates the user account but doesn’t set passwords, home directories, or shell interactively unless we pass specific options.
For example:

useradd -m -s /bin/bash devuser
passwd devuser


Here -m creates the home directory and -s sets the shell.

adduser is actually a Perl or shell script wrapper around useradd. It provides an interactive experience — it automatically asks for details like password, full name, and creates the home directory by default.
It’s more user-friendly and commonly used in Debian/Ubuntu systems.

In short, I’d say:
useradd → low-level, non-interactive command
adduser → high-level, interactive wrapper for user creation.

----------------------------------------------------------------------------------------------------------------------------------

password policy - chage
chage -M 90 username
-M 90 → sets maximum password age to 90 days.
Forces the user to change their password every 90 days.

passwd -l username  --> Lock Account
passwd -u username  --> unlock Account

Why important:

“If an employee leaves the team, or if we suspect a compromised account, we don’t delete it immediately — we lock it first.
This disables login without deleting files or history.
In DevOps/SRE, this is critical for incident response and access control management.

----------------------------------------------------------------------------------------------------------------------------------

inode -
 An inode is data structure in linux that stores metadata about a file.eg- permission, size and disk location. but not the filename itself.
 Check inode usage df -i 
 check inode number  ls -i


 Hard Link:--A hard link is like creating another name for the same file — both point to the same inode.
So even if the original file is deleted, the data still exists through the hard link.

A soft link:-
(or symbolic link) is more like a shortcut — it points to the file name, not the inode.
If the original file is deleted, the soft link becomes broken because its target no longer exists.

Hard link → same inode, same data.
Soft link → different inode, just a pointer to the file name

----------------------------------------------------------------------------------------------------------------------------------

Sticky bit :-
The sticky bit is a special permission used on directories to prevent users from deleting or renaming other users’ files inside that directory.
It’s commonly used on shared directories like /tmp, where everyone has write access, but you only want users to delete their own files — not anyone else’s.

chmod +t directory_name - set sticky bit


**systemd**

systemd is the default init system and service manager in most modern Linux distributions like RHEL, Ubuntu, and Amazon Linux.
It’s responsible for booting the system, managing background services (daemons), controlling startup order, and handling dependencies.

/lib/systemd/system/ --> Default OS services.
/etc/systemd/system/ --> Custom or user-defined services

systemctl start <service>
systemctl stop <service>
systemctl restart <service>
systemctl status <service>
systemctl enable <service>
systemctl disable <service>
systemctl daemon-reload

=================================================================================================================================

strace:-

strace stands for system call trace.
It’s a powerful Linux command used to trace the system calls and signals that a process makes while it’s running.

In simple terms, it shows how a process interacts with the Linux kernel — for example, when it opens files, reads data, writes to sockets, creates processes, or accesses the network.

As an SRE or DevOps engineer, I use strace mainly for debugging, performance analysis, and troubleshooting application or service startup issues

cgroup:-

Cgroup stands for Control Group.
It’s a Linux kernel feature that allows you to limit, isolate, and monitor the resource usage of a group of processes — like CPU, memory, disk I/O, or network bandwidth.
Cgroups are the foundation of containers like Docker and Kubernetes — when you run a container, Docker uses cgroups to apply resource limits set in the container configuration (like --memory, --cpus)


