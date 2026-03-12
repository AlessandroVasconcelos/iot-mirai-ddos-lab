FROM alpine:latest

RUN apk update && \
    apk add --no-cache \
    busybox-extras \
    shadow \
    bash \
    curl \
    apache2-utils \
    coreutils \
    iproute2

RUN adduser -D iot && echo "iot:1234" | chpasswd

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 23

CMD ["/entrypoint.sh"]
