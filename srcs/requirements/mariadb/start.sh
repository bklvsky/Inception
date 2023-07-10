#!/bin/bash

echo "IN START.SH MARIADB"

# Necessary for mariadb to be able to create a socket
mkdir -p /var/run/mysqld
chown mysql:mysql /var/run/mysqld/
echo 'chmod -R 755 /var/run/mysqld/'
chmod -R 755 /var/run/mysqld/

# Making sure that mariadb has access to the db directory 
echo 'chown -R 755 /var/lib/mysql/'
chown -R mysql:mysql /var/lib/mysql
echo 'chmod -R 755 /var/lib/mysql/'
chmod -R 755 /var/lib/mysql/

# echo "MYSQL_NAME =$MYSQL_NAME"
# echo "MYSQL_USER =$MYSQL_USER"
# echo "MYSQL_PASSWORD =$MYSQL_PASSWORD"
# echo "MYSQL_ROOT_PASSWORD =$MYSQL_ROOT_PASSWORD"

if [ ! -d /var/lib/mysql/$MYSQL_NAME ] ; then
	service mysql start
	mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_NAME;"

	mysql -u root -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_NAME.* TO '$MYSQL_USER'@'%';"
	mysql -u root -e "CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_NAME.* TO '$MYSQL_USER'@'localhost';"
	mysql -e "FLUSH PRIVILEGES;"


	mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_NAME.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
	mysql -u root -e "FLUSH PRIVILEGES;"

	# let the sql queries to be completed and stop mysql service
	sleep 5
	service mysql stop
else
	echo "we didn't need to create anything!"
fi

# make sure that the service has stopped and use safe mysqld_safe daemon
# we can't use mysql service here, this way the docker finishes 
sleep 5
mysqld_safe

# echo 'database is running'
# service mysql status
# mysqld_safe