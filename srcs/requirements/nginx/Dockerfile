#  penultimate stable version

FROM debian:buster
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y \
    nginx \
    openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/dselmy.key \
    -out /etc/ssl/certs/dselmy.crt \
    -subj "/C=$OPENSSL_C/ST=$OPENSSL_ST/L=$OPENSSL_L/O=$OPENSSL_O/OU=$OPENSSL_OU/CN=$OPENSSL_CN/"
RUN echo "openssl_c = $OPENSSL_C, openssl_l = $OPENSSL_L, st = $OPENSSL_ST"
COPY ./default /etc/nginx/sites-available/default
RUN chmod 755 etc/nginx/sites-available/default

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
