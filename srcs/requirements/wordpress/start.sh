#!/bin/bash

echo 'IN START.SH POSTGRES'
# mkdir -p /run/php-fmp/
# sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g" "/etc/php/7.3/fpm/pool.d/www.conf"

mv ./www.conf /etc/php/7.3/fpm/pool.d/
# pwd

echo "MYSQL_NAME =$MYSQL_NAME"
echo "MYSQL_USER =$MYSQL_USER"
echo "MYSQL_PASSWORD =$MYSQL_PASSWORD"
echo "MYSQL_ROOT_PASSWORD =$MYSQL_ROOT_PASSWORD"


if  [ ! -f "/var/www/html/wp-config.php" ]; then
	# mkdir -p /var/www/html/

	# echo "downloading wordpress"
	# wget https://wordpress.org/latest.tar.gz
	# tar -xzf latest.tar.gz
	# rm -f latest.tar.gz
	# mv wordpress/* /var/www/html/
	# rmdir wordpress
	# mv ./wp-config.php /var/www/html/
	# rm -f /var/www/html/wp-config-sample.php

	# we need to download wp-cli to create 2 users from terminal

	echo 'installing cli' 
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	sleep 5

	wp core download --allow-root --path=/var/www/html/
	mv ./wp-config.php /var/www/html/

	sleep 5

	cd /var/www/html/
	echo "Creating admin user $WP_ADMIN_USER"
	wp core install  --allow-root \
		--url=${WP_URL} \
		--title="${WP_TITLE}" \
		--admin_user=${WP_ADMIN_USER} \
		--admin_password=${WP_ADMIN_PASSWORD} \
		--admin_email=${WP_ADMIN_EMAIL}

	echo "Creating user $WP_USER"
	wp user create --allow-root \
		${WP_USER} ${WP_USER_EMAIL}\
		--user_pass=${WP_USER_PASSWORD}
else
	echo 'Updating wp-config.php'
	mv ./wp-config.php /var/www/html/
fi

# wordpress-config.php apparently doesn't retrieve .env variables with getenv
# so we can substitute them from the .sh script
echo 'what in var/www/html wordpress rn'
ls /var/www/html/
# echo 'WP_CONFIG.PHP'
# cat /var/www/html/wp-config.php

echo 'start php-fpm'
mkdir -p /run/php/
php-fpm7.3 --nodaemonize
