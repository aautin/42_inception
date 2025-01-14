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
CREATE DATABASE wordpress;
END

#mariadb wordpress users configuration
mariadb << END
CREATE USER '$ADMIN_USERNAME'@'$ADMIN_HOST' IDENTIFIED BY '$ADMIN_PASSWORD';
GRANT ALL PRIVILEGES ON * . * TO '$ADMIN_USERNAME'@'$ADMIN_HOST';

CREATE USER '$WP_USERNAME'@'$WP_HOST' IDENTIFIED BY '$WP_PASSWORD';
GRANT ALL PRIVILEGES ON wordpress.* TO '$WP_USERNAME'@'$WP_HOST';

FLUSH PRIVILEGES;
END

#stop and restart mariadb in foreground
service mariadb stop && exec mariadbd
