#!/bin/bash

if ! test -d /run/php
then
	mkdir -p /run/php
fi

if ! test -d /var/www/html
then
	mkdir -p /var/www/html
fi

if test -f /tmp/adminer.php
then
	mv /tmp/adminer.php /var/www/html/
fi

if test -f /tmp/www.conf
then
	cp /etc/php/7.3/fpm/pool.d/www.conf /etc/php/7.3/fpm/pool.d/www.conf.bak
	mv /tmp/www.conf /etc/php/7.3/fpm/pool.d/
	chmod +r /etc/php/7.3/fpm/pool.d/www.conf
	chown www-data:www-data /etc/php/7.3/fpm/pool.d/www.conf
fi

# grant rights/user/group to all files in html
chmod -R 755 /var/www/html/* 
chown -R www-data:www-data /var/www/html

# exec php -S 127.0.0.1:9001 -t /var/www/html

exec php-fpm7.3 --nodaemonize

# tail -f
