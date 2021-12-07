#!/bin/bash

echo "CREATE DATABASE IF NOT EXISTS ${WP_DB};\
	CREATE USER IF NOT EXISTS '${WP_DB_USER}'@'${WP_DB_HOST}' IDENTIFIED BY '${WP_DB_PASS}';\
	GRANT USAGE ON *.* TO '${WP_DB_USER}'@'%' IDENTIFIED BY '${WP_DB_PASS}';\
	GRANT ALL PRIVILEGES ON ${WP_DB}.* TO '${WP_DB_USER}'@'%';\
	FLUSH PRIVILEGES;" | mysql -u root --password=${WP_DB_PASS}
