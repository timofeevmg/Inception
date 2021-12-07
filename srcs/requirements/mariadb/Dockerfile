FROM	debian:buster

EXPOSE	3306

RUN		apt-get update && apt-get upgrade -y

RUN		apt-get -y install nano mariadb-server

COPY	tmp/ /tmp/

CMD		bash /tmp/start.sh
