#!/bin/bash

SERVERS=( login-server char-server map-server )

for SERVER in "${SERVERS[@]}"; do
    ./build/Hercules/${SERVER}
done