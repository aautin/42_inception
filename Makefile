MARIADB_VOLUME=/home/aautin/data/mysql
WORDPRESS_VOLUME=/home/aautin/data/wordpress
UID=$(shell id -u)


all: build_volumes up

up:
	docker compose --project-directory srcs up --build --detach
down:	
	docker compose --project-directory srcs down --volumes


mariadb:
	docker compose --project-directory srcs up mariadb --build --force-recreate --detach
wordpress:
	docker compose --project-directory srcs up wordpress --build --force-recreate --detach
nginx:
	docker compose --project-directory srcs up nginx --build --force-recreate --detach


enter_mariadb:
	docker exec -it mariadb '/bin/bash'
enter_wordpress:
	docker exec -it wordpress '/bin/bash'
enter_nginx:
	docker exec -it nginx '/bin/bash'

logs_mariadb:
	docker compose --project-directory srcs logs mariadb
logs_wordpress:
	docker compose --project-directory srcs logs wordpress
logs_nginx:
	docker compose --project-directory srcs logs nginx
logs:
	docker compose --project-directory srcs logs


$(MARIADB_VOLUME):
	mkdir -p $@
$(WORDPRESS_VOLUME):
	mkdir -p $@
build_volumes: $(MARIADB_VOLUME) $(WORDPRESS_VOLUME)
ls_volumes:
	ls $(MARIADB_VOLUME)
	ls $(WORDPRESS_VOLUME)
clean_volumes:
	docker run --rm -v $(MARIADB_VOLUME):/to_rm/ debian:bullseye chown -R $(UID) /to_rm/
	docker run --rm -v $(WORDPRESS_VOLUME):/to_rm/ debian:bullseye chown -R $(UID) /to_rm/
	rm -rf $(MARIADB_VOLUME)
	rm -rf $(WORDPRESS_VOLUME)
	

.PHONY: all   up down   mariadb wordpress nginx   enter_mariadb enter_wordpress   logs logs_mariadb logs_wordpress logs_nginx   build_volumes ls_volumes clean_volumes
