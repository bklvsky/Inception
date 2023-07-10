FROM debian:buster

# WORKDIR /var/www

RUN apt-get update && apt-get install -y mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/
RUN chmod 755 /etc/mysql/mariadb.conf.d/50-server.cnf

COPY start.sh ./
EXPOSE 3306

# RUN chmod 755 /var/lib/mysql/

RUN chmod +x ./start.sh
# RUN service mysql start
ENTRYPOINT [ "./start.sh" ]
