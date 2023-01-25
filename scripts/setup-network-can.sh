#!/bin/bash

cd ~/build-cqptoolkit
./stopTest.sh
cd ~/openquantumsafe/qkd-net/kms
./scripts/stop
./scripts/cleanup
screen -d -m ./scripts/run
