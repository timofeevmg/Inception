FROM	debian:buster

EXPOSE	8080

RUN		apt-get update && apt-get upgrade -y

RUN		apt-get -y install nano nginx

COPY	tmp/ /tmp/

CMD		bash /tmp/start.sh