create user 'demo'@'%' identified by 'demo' ;
grant all on demo.* to demo ;
delete from mysql.user where host = 'localhost' and user ='' ;
FLUSH PRIVILEGES;

