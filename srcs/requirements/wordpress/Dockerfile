FROM wordpress

# RUN apt-get update && apt-get install -y \
#     mariadb-client \
#     php7.3 \
#     php-fpm \
#     php-curl \
#     php-json \
#     php-mysql \
#     wget

WORKDIR /var/www/html/wordpress

# RUN wget https://wordpress.org/latest.tar.gz
# RUN tar -xzf latest.tar.gz && rm -f latest.tar.gz
# RUN mv wordpress/* . && rmdir wordpress

RUN rm ./wp-config-sample.php
COPY wp-config.php ./
RUN chmod 755 ./wp-config.php


