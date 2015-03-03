#!/usr/bin.bash

mysql_install_db
chown -R mysql:mysql /var/lib/mysql
/usr/bin/mysqld_safe --datadir=/var/lib/mysql &
mysqladmin password 123
mysql --socket=/var/lib/mysql/mysql.sock -u root --password=123 < /bin/master.sql
