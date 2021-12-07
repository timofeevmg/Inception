#!/bin/bash

# create sertificate (already created in debian VM)
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
# -keyout /home/epilar/inception/srcs/requirements/nginx/tmp/ssl/nginx-selfsigned.key \
# -out /home/epilar/inception/srcs/requirements/nginx/tmp/ssl/nginx-selfsigned.crt \
# -subj "/C=RU/ST=TATARSTAN/L=KAZAN/O=NO/OU=NO/CN=42.epilar.fr"

# ssl sertificate&key
if test -d /tmp/ssl
then
	mv /tmp/ssl /var/
fi

# nginx configuration
if test -f /tmp/my_conf.conf
then
	mv /tmp/my_conf.conf /etc/nginx/sites-available/
fi

if ! test -L /etc/nginx/sites-enabled/my_conf.conf
then
	ln -s /etc/nginx/sites-available/my_conf.conf /etc/nginx/sites-enabled/my_conf.conf
fi

if test -f /tmp/index.html
then
	mv /tmp/index.html /var/www/html/
fi

if test -f /tmp/index.php
then
	mv /tmp/index.php /var/www/html/
fi

chmod +r /var/www/html/index.*

# run nginx as no-deamon instead of bash to be PID 1 in container
exec nginx -g 'daemon off;'
