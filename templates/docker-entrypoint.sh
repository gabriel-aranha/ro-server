#!/bin/bash

servers=( login-server char-server map-server )
for server in "${servers[@]}"; do
    screen -dmS "$server" -L -Logfile "/Hercules/log/$server.log" "/Hercules/$server"
done
tail -f /Hercules/log/*.log