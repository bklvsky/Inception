#  penultimate stable version

FROM debian:buster
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y \
    nginx \
    openssl

COPY ./nginx_config /etc/nginx/sites-available/nginx_config
RUN chmod 755 etc/nginx/sites-available/nginx_config

COPY ./start.sh ./
RUN chmod 755 ./start.sh

EXPOSE 443

ENTRYPOINT ["./start.sh"]
# CMD ["-g", "daemon off;"]
