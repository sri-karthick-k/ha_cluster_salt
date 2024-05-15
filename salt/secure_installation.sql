ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';


CREATE USER 'phpmyadmin'@'%' IDENTIFIED BY 'phppasswd';
GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'%' WITH GRANT OPTION;

CREATE USER 'haproxy'@'%';


FLUSH PRIVILEGES;
