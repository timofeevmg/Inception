#!/bin/bash

# nginx configuration
if test -f /tmp/my_conf.conf
then
	mv /tmp/my_conf.conf /etc/nginx/sites-available/
fi

if ! test -L /etc/nginx/sites-enabled/my_conf.conf
then
	ln -s /etc/nginx/sites-available/my_conf.conf /etc/nginx/sites-enabled/my_conf.conf
fi

if test -d /tmp/cv
then
	mv /tmp/cv /var/www/html/
	chmod -R +r /var/www/html/*
	chown -R www-data:www-data /var/www/html
fi

# run nginx as no-deamon instead of bash to be PID 1 in container
exec nginx -g 'daemon off;'