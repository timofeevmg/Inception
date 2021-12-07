#!/bin/bash

# directory for pid file of php-fpm
if ! test -d /run/php
then
	mkdir -p /run/php
fi

# change port in www.conf of php-fpm
sed -i 's+listen = /run/php/php7.3-fpm.sock+listen = 9000+g' \
		/etc/php/7.3/fpm/pool.d/www.conf

# grant rights/user/group to wordpress files
chmod -R 755 /var/www/html/wordpress 
chown -R www-data /var/www/html/wordpress
chgrp -R www-data /var/www/html/wordpress

# install wp cli
if test -f /tmp/wp-cli.phar
then
	chmod +x /tmp/wp-cli.phar
	mv /tmp/wp-cli.phar /usr/local/bin/wp
fi

echo 'path: /var/www/html/wordpress' > wp-cli.yml

# setup wordpress using wp cli
chmod +x /tmp/wp_setup.sh
./tmp/wp_setup.sh

exec php-fpm7.3 --nodaemonize
