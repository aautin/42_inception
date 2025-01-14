FROM debian:bullseye
RUN apt-get update && apt-get -y install mariadb-server

COPY ./entrypoint.sh /entrypoint.sh
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
