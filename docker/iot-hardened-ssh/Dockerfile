FROM alpine:latest

# 1. Instalar OpenSSH e dependências de rede (iproute2 para o GNS3 configurar IP)
RUN apk update && \
    apk add --no-cache \
    openssh \
    openssh-server \
    bash \
    iproute2

# 2. Configurar o SSH para segurança (Hardening)
# Cria diretório do SSH
RUN mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh

# Copia a chave pública autorizada (mitigação contra brute-force de senha)
COPY authorized_keys /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# 3. Ajustes de Segurança no sshd_config
# - Desabilita login por senha (PasswordAuthentication no)
# - Permite root apenas via chave (PermitRootLogin prohibit-password)
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config

# 4. Copiar script de inicialização
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 5. Expor Porta 22 (SSH) e NÃO a 23 (Telnet)
EXPOSE 22

CMD ["/entrypoint.sh"]
