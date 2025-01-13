all:	up

up:
	docker compose --project-directory srcs up --detach

build: 
	docker compose --project-directory srcs build

down:	
	docker compose --project-directory srcs down

enter_mariadb:
	docker exec -it mariadb '/bin/bash'

logs:
	docker compose --project-directory srcs logs

logs_mariadb:
	docker compose --project-directory srcs logs mariadb

.PHONY: all up build down enter_mariadb logs logs_mariadb
