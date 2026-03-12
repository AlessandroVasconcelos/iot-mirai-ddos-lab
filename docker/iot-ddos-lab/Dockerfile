FROM alpine:latest

RUN apk update && \
    apk add --no-cache \
    busybox-extras \
    bash \
    expect \
    iproute2 \
    openssh

COPY mirai_lab.exp /root/mirai_lab.exp
COPY mirai_ssh.exp /root/mirai_ssh.exp
COPY wordlist.txt /root/wordlist.txt
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /root/mirai_lab.exp /root/mirai_ssh.exp /entrypoint.sh

WORKDIR /root

CMD ["/entrypoint.sh"]
