#!/bin/bash

$SERVER_APP_PATH -msfStartMaster -msfStartSpawner -msfMasterIp $SERVER_IP -msfMachineIp $SERVER_IP -msfExe $SERVER_APP_PATH -batchmode -nographics -logfile &
