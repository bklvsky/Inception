
echo "IN START.SH MARIADB"

sed -i "s/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/" "/etc/mysql/mariadb.conf.d/50-server.cnf"

mysql -e "CREATE DATABASE $DB_NAME;"
mysql -e "CREATE USER '$DB_USER'@'$DB_HOST' IDENTIFIED BY '$DB_PASSWORD';"
mysql -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'$DB_HOST';"
mysql -e "FLUSH PRIVILEGES;"

mysqld
