FROM debian:buster

RUN apt-get update && apt-get install -y \
    mariadb-client \
    php7.3 \
    php-fpm \
    php-curl \
    php-json \
    php-mysql \
    wget

# WORKDIR /var/www/html/

COPY wp-config.php ./
RUN chmod 755 ./wp-config.php

COPY www.conf ./
RUN chmod 755 ./www.conf

COPY start.sh ./
RUN chmod 755 ./start.sh

EXPOSE 9000

ENTRYPOINT [ "./start.sh" ]
