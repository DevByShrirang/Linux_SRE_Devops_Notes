#!/bin/bash

#timestamp
TIMEESTAMP=$(date "+%Y-%M-%D %H-%M-%S")

echo "cpu Load:"
uptime

echo "memory usage:"
free -m

echo "Disk usage:"
df -h /