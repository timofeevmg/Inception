#!/bin/bash

if test -d /tmp/ssl
then
	mv /tmp/ssl /var/
	chmod -R +r /var/ssl
fi

if test -f /tmp/vsftpd.conf
then
	mv /etc/vsftpd.conf /etc/vsftpd.conf.bak
	mv /tmp/vsftpd.conf /etc/
	chmod 644 /etc/vsftpd.conf
fi

if ! test -d /var/ftp/empty
then
	mkdir -p /var/ftp/empty
fi

# create user and home dir
if ! grep "${FTP_USER}" /etc/passwd
then
	# adduser ${FTP_USER}
	useradd -d /home/${FTP_USER} ${FTP_USER}
	echo -e "${FTP_PASS}\n${FTP_PASS}\n" | passwd ${FTP_USER}
	chown ${FTP_USER} /home/${FTP_USER}
	echo ${FTP_USER} > /etc/vsftpd.userlist
	chown nobody:nogroup /home/${FTP_USER}/ftp
	chmod a-w /home/${FTP_USER}/ftp
	chown ${FTP_USER}:${FTP_USER} /home/${FTP_USER}/ftp/files
fi

exec vsftpd /etc/vsftpd.conf

# tail -f