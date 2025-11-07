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
