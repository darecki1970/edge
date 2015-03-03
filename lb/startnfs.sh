#!/usr/bin/bash

/usr/sbin/rpcbind &&
/usr/sbin/exportfs -r &&
/usr/sbin/rpc.nfsd 4 &&
/usr/sbin/rpc.mountd 

