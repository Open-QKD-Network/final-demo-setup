#!/bin/bash

# Check every 5 seconds if lsrp.log exists; fail if no log exists after 2 minutes
for i in {1..24}
do
    sleep 5
    [ -f ~/qkd_logs/lsrp.log ] && break
done && echo "Network up" || echo "Failed to create network (LSRP log not found after 2 minutes)"
