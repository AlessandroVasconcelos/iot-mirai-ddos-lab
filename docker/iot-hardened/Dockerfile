FROM alpine:latest

RUN apk update && \
    apk add --no-cache \
    bash \
    curl \
    coreutils \
    iproute2

# Usuário não-root (boa prática)
RUN adduser -D -s /bin/sh iot

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Sem EXPOSE 23 (telnet removido)
CMD ["/entrypoint.sh"]
