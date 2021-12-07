NAME = docker-compose -f srcs/docker-compose.yml

clean:
	docker rm -f $$(docker ps -a -q)
	# docker rmi -f $$(docker images -a -q)
	docker rmi nginx wordpress mariadb ftp adminer cv
	# docker network rm $$(docker network ls -q)
	docker volume rm $$(docker volume ls -q)
	rm -rf ../data/wordpress/*
	rm -rf ../data/wordpress_db/*

build:
	$(NAME) build $(c)

up:
	$(NAME) up $(c)
	# $(NAME) up -d - run containers in background

.PHONY: clean build up
