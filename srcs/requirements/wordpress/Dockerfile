FROM	debian:buster

EXPOSE	9000

RUN		apt-get update && apt-get upgrade -y

RUN		apt-get -y install nano php7.3-fpm php7.3-mysql php7.3-mbstring

COPY	tmp/ /tmp/

# install wp
RUN		bash -c 'mkdir -p /var/www/html'
RUN		tar -xf /tmp/*.gz -C /var/www/html
RUN		mv /tmp/wp-config.php /var/www/html/wordpress/
RUN		mv /var/www/html/wordpress/wp-config-sample.php \
		/var/www/html/wordpress/wp-config-sample.bak

CMD		bash /tmp/start.sh
