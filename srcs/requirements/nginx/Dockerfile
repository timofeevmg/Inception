FROM	debian:buster

EXPOSE	443

RUN		apt-get update && apt-get upgrade -y

RUN		apt-get -y install nano nginx openssl

COPY	tmp/ /tmp/

CMD		bash /tmp/start.sh
