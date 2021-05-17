#!/bin/bash
SSHPASS=$(sudo cat /usr/local/etc/openconnect/c1)
PUSH='push'

echo -e "${SSHPASS}\n${PUSH}\n" | sudo openconnect nauvpn.nau.edu -b --authgroup=1 --user crk239 --passwd-on-stdin --non-inter
sleep 1
sshpass -f '/usr/local/etc/openconnect/c1' ssh crk239@monsoon.hpc.nau.edu

