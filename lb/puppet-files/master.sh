#!/usr/bin/bash

mysql_install_db
chown -R mysql:mysql /var/lib/mysql
/usr/libexec/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib64/mysql/plugin --user=mysql --log-error=/var/log &
sleep 4 
mysql -u root < /bin/master.sql
mysql -e 'SHOW MASTER STATUS;' | grep demo > /shared/master.status
mysqldump -u root  --opt demo > /shared/demo.sql
mysql -e 'UNLOCK TABLES;'
