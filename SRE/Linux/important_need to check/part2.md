 1. What is the difference between a hard link and a soft link?

 Hard link--  Points directly to the inode of file. even if the original file is deleted , the data remains accessible
 Soft Link -- Points to the filename. if the original file is deleted , the link is broken.

 2. How do you check which process is using a particular port?
 sudo lsof -i :<port_number>
# or
sudo netstat -tulpn | grep <port_number>

3. How to troubleshoot high CPU usage?
top
htop
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head

✅ 6. How to find large files in Linux?
find / -type f -size +500M


**Sticky Bit (t)**

Used mainly on shared directories like /tmp.
Explanation:

When the sticky bit is set on a directory, only the owner of the file (or root) can delete or rename their files inside that directory, even though others have write permissions.

This is important for shared environments, to prevent one user from deleting another user’s files.
ls -ld /tmp
drwxrwxrwt 10 root root 4096 Jun 6 10:00 /tmp

The t at the end (drwxrwxrwt) indicates the sticky bit.
Without it, users could delete others' files if they had write access to the directory.

**systemd service**

systemd is default service  used by linux distribution.
it manages system boot process
           background process
           socket
           timers
           targets
 
systemd service is unit file with (.service extension) that defines how to start, stop and manage background process.(nginx, docker, jenkins)
**how to manage systemd service**
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl status nginx
systemctl enable nginx
systemctl disable nginx
systemctl reload nginx
journalctl -u ngix    ----- shows service logs

file location:- /lib/systemd/system/*.service

**Reloading systemd**
after modifying .service file we need to run below command to reload.
sudo systemctl daemon-reload


**package manager**
package manager is tool is used to install , update and manage software packages on linux system.
eg- apt(advanced package tool) -debian 
    yum (for CentOS and Redhat based)


**Strace**
Powerful linux debugging tool used to trace **system calls and signals** made by process. used to check issue permission denied,
 file not found, why a process is haning.

 strace ls
 shows ls opened the current directory , read files, and wrote output to stdout.

 starce -o trace_output.txt ls
 0 trace_output.txt save all system call logs to file.

 chmod 000 output.txt
 strace cat output.txt ------------->> output will show file permission issue.

Strace command is mainly used to
1) Trace system call and signals
2) identify errors
2) Helps in debugging
3) shows which system calls program is making
4) help to identify where program is failing or misbehaving
5) what order and what return values are


**cgroups**(control groups)-
cgroups is linux kernel feature used to limit , monitor , and isolate resource usage (cpu , memory , disk, i/o , network)
it allows fine grained resource management resource management -essential for container orchestration (like docker , kuberentes)

kubernetes+ cgroups
kubernetes assign cgroups to pod/container based on
request and limits in pod spec

resource:
  request:
   memory: "128Mi"
   cpu: "250m"
  limit:
   memory: "256Mi"
   cpu:  "500m"

   these get mapped to cgroup configuration under the hood by the container runtime.

requests: Guaranteed minimum a container will get.
limits: Maximum the container can consume.


kubernetes schedule containers on worker node and relies on container runtime (docker container) which in turn use cgroups under the hood to enforce resource limits.

kubelet running on every node will passes resource request and limit information to container runtime.
it reads pods specification and instruct the container runtime to start container
it passes cpu and memory constraints to the runtime.
then container runtime creates cgroups
the runtime creates linux cgroup for each contianer

memory and cpu imits written into files
/sys/fs/cgroup/memory/kubepods/pod<uid>/<container-id>/memory.limit_in_bytes
/sys/fs/cgroup/cpu/kubepods/pod<uid>/<container-id>/cpu.cfs_quota_us

Each cgroup is a directory containing control files used by the Linux kernel.








