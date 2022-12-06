#!/bin/bash

cd ~/build-cqptoolkit
./tearDownTest.sh
cd ~/qkd-test/qkd-net/kms
./scripts/stop
./scripts/cleanup
screen -d -m ./scripts/run
