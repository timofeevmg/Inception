#!/bin/bash
if ! wp core is-installed --allow-root
then
	wp core install --allow-root \
					--url=https://${DOMAIN_NAME}/wordpress \
					--title='Test wp site' \
					--admin_user=${WP_DB_USER} \
					--admin_email=${WP_DB_USER}@mail.com \
					--admin_password=${WP_DB_PASS} \
					--skip-email
fi

wp user import-csv --allow-root /tmp/users.csv
