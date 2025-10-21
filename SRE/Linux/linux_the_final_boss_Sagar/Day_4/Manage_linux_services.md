# service control
systemctl status <service> # show service status
systemctl start <service>  # to start service
systemctl stop <service>  # Stop a service
systemctl restart <service> # Restart a service
systemctl reload <service>  # reload config without restart

# Boot management
systemctl enable <service> # Enable service at boot
systemctl disable <service> # Disable service at boot 
systemctl is-enabled <service> # check if enabled

# information
systemctl list-units --type=service  # list all services
systemctl list-units --state=failed # List failed services
systemctl list-unit-files --type=service # List all service files

# logs
journalctl -u <service> # view logs for service
journalctl -u <service> -f # follow logs in real time
journalctl -b              # boot logs

# checking boot logs
dmesg  #  kernel ring buffer
dmesg | grep -i error  # filter for errors
dmesg -T               # Human readable timestamps.

# systemlogs
journalctl -b   # current boot logs
journalctl -b -1 # previous boot logs
journalctl --list-boots  # list all boots
journalctl -p err  # Error priority and above
journalctl --since "1 hour ago"    # Recent logs