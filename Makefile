MARIADB_VOLUME=/home/aautin/data/mysql
UID=$(shell id -u)

all: volumes up

volumes: $(MARIADB_VOLUME)

up:
	docker compose --project-directory srcs up --build --detach

down:	
	docker compose --project-directory srcs down --volumes

mariadb:
	docker compose --project-directory srcs up mariadb --build --force-recreate --detach

enter_mariadb:
	docker exec -it mariadb '/bin/bash'

logs_mariadb:
	docker compose --project-directory srcs logs mariadb

logs:
	docker compose --project-directory srcs logs

$(MARIADB_VOLUME):
	mkdir -p $@

clean_volumes:
	docker run --rm -v $(MARIADB_VOLUME):/to_rm/ debian:bullseye chown -R $(UID) /to_rm/
	rm -rf $(MARIADB_VOLUME)
	

.PHONY: all volumes up build down enter_mariadb logs logs_mariadb clean_volumes
