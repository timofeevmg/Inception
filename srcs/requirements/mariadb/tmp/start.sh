#!/bin/bash

# ## creating socket directory & file ##
# mkdir -p /var/run/mysqld
# mkfifo /var/run/mysqld/mysqld.sock
# chown -R mysql:mysql /var/run/mysqld
# sed -i 's+pid-file                = /run/mysqld/mysqld.pid+pid-file                = /var/run/mysqld/mysqld.pid+g' \
# 		/etc/mysql/mariadb.conf.d/50-server.cnf
# sed -i 's+socket                  = /run/mysqld/mysqld.sock+socket                  = /var/run/mysqld/mysqld.sock+g' \
# 		/etc/mysql/mariadb.conf.d/50-server.cnf
# ######################################

# # general_log_file       = /var/log/mysql/mysql.log
# # general_log            = 1
# sed -i 's+#general_log_file       = /var/log/mysql/mysql.log+general_log_file       = /var/log/mysql/mysql.log+g' \
# 		/etc/mysql/mariadb.conf.d/50-server.cnf
# sed -i 's+#general_log            = 1+general_log            = 1+g' \
# 		/etc/mysql/mariadb.conf.d/50-server.cnf


# unlock port 3306 & lock localhost bind-address in 50-server.cnf of mariadb
sed -i 's+#port                   = 3306+port                    = 3306+g' \
		/etc/mysql/mariadb.conf.d/50-server.cnf
sed -i 's+bind-address            = 127.0.0.1+bind-address            = 0.0.0.0+g' \
		/etc/mysql/mariadb.conf.d/50-server.cnf

service mysql start
# sleep 3
FILE=/var/run/mysqld/mysqld.sock
while true
	do
		if ! test -S $FILE
			then
				sleep 1
			else
				sleep 3
				break
		fi
done

# noninteractive mysql_secure_installation
if test -f /tmp/mariadb_sec_install.sh
then
	chmod +x /tmp/mariadb_sec_install.sh
	./tmp/mariadb_sec_install.sh
	rm -f /tmp/mariadb_sec_install.sh
	sed -i 's+password = +password = '${MDB_ROOT_PASS}'+g' \
		/etc/mysql/debian.cnf
fi

# create db, user, grant privileges
if test -f /tmp/create_db_user.sh
then
	chmod +x /tmp/create_db_user.sh
	./tmp/create_db_user.sh
	rm -f /tmp/create_db_user.sh
fi

service mysql stop

exec mysqld_safe --datadir=/var/lib/mysql/

# tail -f