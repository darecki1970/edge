#!/usr/bin/bash

kill -9 $(pidof mysqld)
/usr/libexec/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib64/mysql/plugin --user=mysql --log-error=/var/log &
sleep 4
mysql -u root < /bin/slave.sql

mysql -e "CHANGE MASTER TO MASTER_HOST='`cat /shared/srv1.txt | awk '{print $1}'`',MASTER_USER='replica', MASTER_PASSWORD='replica', MASTER_LOG_FILE='`cat /shared/master.status | awk '{print $1}'`', MASTER_LOG_POS=`cat /shared/master.status | awk '{print $2}'`;" 
mysql -e 'START SLAVE;'
touch /shared/slave.ready
