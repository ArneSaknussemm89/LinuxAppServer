#!/bin/bash

# Run Confd to make config files
/usr/local/bin/confd -onetime -backend env

open -n -a $SERVER_APP --args -msfStartMaster -msfStartSpawner -msfMasterIp $SERVER_IP -msfMachineIp $SERVER_IP -msfExe $SERVER_APP_PATH