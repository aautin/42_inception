#!/bin/sh

#install wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

##install wordpress
mkdir -p /var/www/html
cd /var/www/html
wp core download --allow-root
wp config create --dbname=$DB_NAME --dbuser=$WP_USERNAME --dbpass=$WP_PASSWORD --allow-root --dbhost=mariadb:3306

#start php in foreground
exec php-fpm7.4 --nodaemonize
