FROM alpine:latest

# Instala pacotes
RUN apk add --no-cache openssh openssh-server bash iproute2 shadow

# --- CORREÇÃO DEFINITIVA DO SSH ---
# Em vez de editar, sobrescrevemos o arquivo sshd_config inteiro.
# Isso garante que NÃO existam configurações ocultas bloqueando a senha.
RUN echo "Port 22" > /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config && \
    echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config && \
    echo "UsePAM no" >> /etc/ssh/sshd_config

# Gera as chaves do servidor
RUN ssh-keygen -A

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22
CMD ["/entrypoint.sh"]
