~ shwoing we are in home directory

Essential system directories-
/bin /sbin /lib /boot /dev /etc /proc /sys /run

/bin - contains essential user command and binaries, (eg ls,cat ,cp) required for all users. --- accessible by everyone.
/sbin- it is for system binaries. where administrative commands can place. only admin use those commands - used by root
/lib - store essential shared library required by binaries in /bin and /sbin. --   used by system/binaries
/boot - stores bootloader files. kernel images(vmlinuz) ,and initial ram filesystem(initramfs) -needed during system startup
/dev - contains device files representing hardware.(dev/sda) used by kernel and admin
/etc  -store system configuration files. (eg etc/fstab, etc/passwd)  used by admin/system
/proc  -- virtual filesystem provide runtime process information-(eg-/proc/cpuinfo , /proc/meminfo) - readable by all 
/sys --virtual filesystem providing system and hardware information exported by the kernel - used by system/scripts
/run -- stores run time variable data.   --system processes

user data & home-
/home/shrirang  --> is the personal workspace for user shrirang . user store file, configuration, personal data here
/root            --> home directory for root user - this is place where root users persoanl file, configurations scripts are stored.



variable & temporary data-
/var   /temp
/var  -- used by different web servers for variable data.
/tmp --  if we want to store something temporary which can get autodeleted autoclean after some time.

software & user programs
/usr /usr/bin  /usr/local  /opt

/usr -- contains user programs, documentation.
/usr/bin -- non-essntials system binaries
/usr/local -- used for installing for local software
/opt - used for installing additonal software

mount points
/mnt    /media  /srv

/mnt -- it use temp mount point  for filesytem
/media -- removable mediasoftwares.
/srv - data for services.