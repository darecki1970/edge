GRANT REPLICATION SLAVE ON *.* TO 'replica'@'%' IDENTIFIED BY 'replica' ;
create database demo;
create table demo.demo (id int not null primary key);
insert into demo.demo values (23),(25),(33),(67),(666);
create user 'demo'@'%' identified by 'demo' ;
grant all on demo.* to demo ;
delete from mysql.user where host = 'localhost' and user ='' ;
FLUSH PRIVILEGES;
use demo;
FLUSH TABLES WITH READ LOCK;

