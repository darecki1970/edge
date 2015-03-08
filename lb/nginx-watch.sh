#!/usr/bin/bash

while   [ ! -f /shared/srv2.txt ] ||  [ ! -f /shared/srv1.txt ] || [ ! -f /shared/slave.ready ]
do
      sleep 2
done
cat /shared/srv2.txt >> /etc/hosts
cat /shared/srv1.txt >> /etc/hosts
/usr/sbin/nginx -c /etc/nginx/nginx.conf &
