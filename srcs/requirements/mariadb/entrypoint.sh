#!/bin/sh

#mariadb installation
service mariadb start && mysql_secure_installation << END

n
n
y
y
y
y
END

#mariadb wordpress database configuration
mariadb << END
CREATE DATABASE $DB_NAME;
END

#mariadb wordpress users configuration
mariadb << END
CREATE USER '$DB_ADMIN_USERNAME'@'$DB_ADMIN_HOST' IDENTIFIED BY '$DB_ADMIN_PASSWORD';
GRANT ALL PRIVILEGES ON * . * TO '$DB_ADMIN_USERNAME'@'$DB_ADMIN_HOST';

CREATE USER '$DB_USERNAME'@'$DB_HOST' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USERNAME'@'$DB_HOST';

FLUSH PRIVILEGES;
END

#stop and restart mariadb in foreground
service mariadb stop && exec mariadbd
