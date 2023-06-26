FROM debian:buster

WORKDIR /var/www

RUN apt-get update && apt-get install -y mariadb-server
COPY start.sh ./
EXPOSE 3306


RUN chmod +x ./start.sh
RUN service mysql start
ENTRYPOINT [ "./start.sh" ]
