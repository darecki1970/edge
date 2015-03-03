#!/usr/bin/bash

cp /root/hosts /etc/hosts
ip a d `ip a | grep inet | grep eth0 | awk '{print $2}'` dev eth0
ip a add 192.168.10."$1"/32 dev eth0
ip r add 192.168.0.0/16 dev eth0 proto kernel scope link src 192.168.10."$1"
ip r add default via 192.168.0.1 dev eth0
hostname "$2"
