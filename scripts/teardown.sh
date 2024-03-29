#!/bin/bash

cd ~/build-cqptoolkit
./stopTest.sh

rm -rf ~/.qkd/kms/pools
rm -rf ~/.qkd/qnl/otp/keys
rm -rf ~/.qkd/mapping.log
rm -rf ~/qkd_logs/*.*
rm -rf ~/.qkd/qnl/qll/keys/A/A_*
rm -rf ~/.qkd/qnl/qll/keys/B/B_*
rm -rf ~/.qkd/qnl/qll/keys/C/C_*
rm -rf ~/.qkd/qnl/qll/keys/D/D_*
rm -rf ~/.qkd/qnl/qll/keys/E/E_*
rm -rf ~/.qkd/qnl/qll/keys/F/F_*

killall screen
