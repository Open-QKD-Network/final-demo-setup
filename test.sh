#!/bin/bash

echo -e "\nSetting up dummy drivers..."
for s in "can1 A" "can2 B" "can3 C" "uk1 D" "uk2 E"
do
    set -- $s # convert tuple to args
    ssh -F ./ssh/config $1 "cd ~/build-cqptoolkit && ./setupTest3$2.sh"
done
