#!/bin/bash
PASS=$(sudo cat /usr/local/etc/openconnect/c1)
PUSH='push'

echo -e "${PASS}\n${PUSH}\n" | sudo openconnect nauvpn.nau.edu -b --authgroup=1 --user crk239 --passwd-on-stdin --non-inter
