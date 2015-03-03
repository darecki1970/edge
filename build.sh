#!/usr/bin/bash

docker build -t edge-lb ./lb/
docker create --privileged --name="loadbalancer"  edge-lb
docker start loadbalancer
docker build -t edge-srv ./srv/
docker create --privileged --name="srv1"  edge-srv
docker start srv1


