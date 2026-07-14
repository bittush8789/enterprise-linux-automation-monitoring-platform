#!/bin/bash
# Disk Cleanup Script

THRESHOLD=85

df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  
  if [ $usep -ge $THRESHOLD ]; then
    echo "Running cleanup on $partition because it is at $usep% usage."
    # Clean apt cache
    apt-get clean
    apt-get autoremove -y
    
    # Clean systemd journals older than 7 days
    journalctl --vacuum-time=7d
    
    # Clean /tmp
    find /tmp -type f -atime +7 -delete
    
    echo "Cleanup finished on $partition."
  fi
done
