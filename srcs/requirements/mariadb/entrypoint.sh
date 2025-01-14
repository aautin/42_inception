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

#mariadb users configuration
mariadb << END
CREATE USER "$ADMIN_USERNAME"@"$ADMIN_HOST" IDENTIFIED BY "$ADMIN_PASSWORD";
GRANT ALL PRIVILEGES ON * . * TO "$ADMIN_USERNAME"@"$ADMIN_HOST";
FLUSH PRIVILEGES;
END

#stop and restart mariadb in foreground
service mariadb stop && exec mariadbd
