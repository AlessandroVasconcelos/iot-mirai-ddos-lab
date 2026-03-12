FROM alpine:latest

RUN apk update && \
    apk add --no-cache apache2 iproute2

COPY index.html /var/www/localhost/htdocs/index.html
COPY httpd.conf /etc/apache2/httpd.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

CMD ["/entrypoint.sh"]
