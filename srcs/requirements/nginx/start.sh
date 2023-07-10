#!/bin/bash

# echo 'IN START.SH NGINX'
# echo "openssl_c = $OPENSSL_C, openssl_l = $OPENSSL_L, st = $OPENSSL_ST"

rm -f /etc/nginx/sites-enabled/default \
	/etc/nginx/sites-enabled/nginx_config
ln -s /etc/nginx/sites-available/nginx_config /etc/nginx/sites-enabled/

chmod 755 /var/www/html
# chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/html/*

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/dselmy.key \
-out /etc/ssl/certs/dselmy.crt \
-subj "/C=$OPENSSL_C/ST=$OPENSSL_ST/L=$OPENSSL_L/O=$OPENSSL_O/OU=$OPENSSL_OU/CN=$OPENSSL_CN/"

echo 'Launching Nginx...'
nginx -g "daemon off;"