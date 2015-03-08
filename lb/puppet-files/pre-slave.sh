#!/usr/bin/bash

mysql_install_db
chown -R mysql:mysql /var/lib/mysql
/usr/libexec/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib64/mysql/plugin --user=mysql --log-error=/var/log &
sleep 4
mysqladmin create demo
mysql -u root  demo < /shared/demo.sql
mysql -e "GRANT REPLICATION SLAVE ON *.* TO 'replica'@'%' IDENTIFIED BY 'replica' ;"
mysql -e "FLUSH PRIVILEGES;"

