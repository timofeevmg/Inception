FROM	debian:buster

EXPOSE	9001

RUN		apt-get update && apt-get upgrade -y

RUN		apt-get -y install nano php7.3 php7.3-fpm php7.3-mysql php7.3-mbstring

COPY	tmp/ /tmp/

CMD		bash /tmp/start.sh