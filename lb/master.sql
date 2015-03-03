GRANT REPLICATION SLAVE ON *.* TO replica@192.168.10.102 IDENTIFIED BY 'replica'
;
create database demo;
create table demo.demo (id int not null primary key);
insert into demo.demo values (23),(25),(33),(67),(666);

