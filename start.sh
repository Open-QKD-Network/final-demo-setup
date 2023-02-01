#!/bin/bash

echo "Setting up network..."

for s in can1 can2 can3
do
    echo -e "\nTearing down existing network and running openqkd on ${s}"
    ssh -F ./ssh/config ${s} 'bash -s' < ./scripts/setup-network-can.sh
    echo "Complete!"
done

for s in uk1 uk2
do
    echo -e "\nTearing down existing network and running openqkd on ${s}"
    ssh -F ./ssh/config ${s} 'bash -s' < ./scripts/setup-network-uk.sh
    echo "Complete!"
done

#for s in can1 can2 can3 uk1 uk2
#do
#    echo -e "\nWaiting for network to start on ${s}..."
#    ssh -F ./ssh/config ${s} 'bash -s' < ./scripts/wait-lsrp.sh
#done


#echo -e "\nVerifying network configuration is correct..."
#diff <(sort ./assets/lsrp.log) <(sort <(ssh -F ./ssh/config can1 'cat qkd_logs/lsrp.log'))
#if [ $? -ne 0 ]; then
#    echo "Network misconfigured (lsrp.log incomplete)!"
#    ./stop.sh
#    exit
#fi
#echo "Verification complete!"

echo "Waiting for nodes to start..."
sleep 180

echo -e "\nSetting up satellite driver..."
ssh -F ./ssh/config can3 'bash -s' < ./scripts/setup-satellite.sh
echo "Complete!"

echo -e "\nSetting up dummy drivers..."
for s in "can1 A" "can2 B" "can3 C" "uk1 D" "uk2 E"
do
    echo -e "\nStarting dummy drivers on node ${s}"
    set -- $s # convert tuple to args
    ssh -F ./ssh/config $1 "cd ~/build-cqptoolkit && ./startTest$2.sh"
    sleep 2
done

echo -e "\nStarting dashboard backends..."
for s in "can1 A" "can2 B" "can3 C" "uk1 D" "uk2 E"
do
    echo -e "\nStarting dashboard aws on node ${s}"
    set -- $s # convert tuple to args
    ssh -F ./ssh/config $1 "cd ~/qkd-dashboard/aws-server && ./startAWS.sh"
    sleep 2
done

echo -e "\nStarting dashboard backend server on CAN 1..."
for s in "can1 A"
do
    set -- $s # convert tuple to args
    ssh -F ./ssh/config $1 "cd ~/qkd-dashboard/web-server/server && ./startServer.sh"
    sleep 2
done

echo -e "\nStarting dashboard front-end server on CAN 1..."
for s in "can1 A"
do
    set -- $s # convert tuple to args
    ssh -F ./ssh/config $1 "cd ~/qkd-dashboard/web-server/front-end && ./startFrontend.sh"
    sleep 2
done

echo -e "\nConfiguration complete!"
