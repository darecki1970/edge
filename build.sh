#!/usr/bin/bash

docker build -tq edge-lb ./lb/
docker create  -p 192.168.168.203:80:80 -h puppet --privileged --name="loadbalancer"  edge-lb
docker start loadbalancer
docker build -tq edge-srv ./srv/
docker create --privileged --name="srv1" -h srv1 --link loadbalancer:puppet  edge-srv
docker start srv1
echo "konfiguracja srv1"
while  
[ `docker exec -it loadbalancer ls /shared | grep -c master.status` -lt 1 ]
do
      echo -n . 
      sleep 5
done
echo
docker create --privileged --name="srv2" -h srv2 --link loadbalancer:puppet  edge-srv
docker start srv2
echo "konfiguracja srv2"
while
[ `docker exec -it loadbalancer ls /shared | grep -c slave.ready` -lt 1 ]
do
      echo -n .
      sleep 5
done
echo
echo "system gotowy pod adresem http://192.168.168.203:80"

