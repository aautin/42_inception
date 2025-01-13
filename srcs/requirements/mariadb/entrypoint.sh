#!/bin/sh
service mariadb start

mysql_secure_installation << END
n
n
y
y
y
y
END

service mariadb stop && mariadbd
