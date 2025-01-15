FROM debian:bullseye
RUN apt update && apt install wget curl zip unzip -y

RUN apt install php php-fpm php-mysql php-xml php-gd php-mbstring php-curl -y

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
