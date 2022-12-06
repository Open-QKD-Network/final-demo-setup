#!/bin/bash

echo "Tearing down network"

for s in can1 can2 can3 uk1 uk2
do
    echo -e "\nCleaning up network on ${s}"
    ssh -F ./ssh/config ${s} 'bash -s' < ./scripts/teardown.sh
done

echo -e "\nStopping satellite driver"
ssh -F ./ssh/config can3 'killall python3'
