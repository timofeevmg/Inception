FROM	debian:buster

EXPOSE	21 10015

RUN		apt-get update && apt-get upgrade -y

RUN		apt-get -y install nano vsftpd

COPY	tmp/ /tmp/

CMD		bash /tmp/start.sh
