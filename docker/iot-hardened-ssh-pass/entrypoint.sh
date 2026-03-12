#!/bin/sh
set -e

# 1. Configuração de Rede
ip link set eth0 up || true
if [ -n "${IP_ADDR:-}" ]; then
  ip addr flush dev eth0 || true
  ip addr add "${IP_ADDR}/24" dev eth0 || true
fi

# 2. Configuração de Variáveis
USER_NAME="${IOT_USER:-iot}"
USER_PASS="${IOT_PASS:-1234}"

# 3. Criação do usuário comum (se não existir)
if ! id "$USER_NAME" >/dev/null 2>&1; then
    adduser -D -s /bin/bash "$USER_NAME"
fi

# 4. DEFININDO AS SENHAS (O Pulo do Gato)
# Define a senha do usuário comum
echo "$USER_NAME:$USER_PASS" | chpasswd

# --- CORREÇÃO: Define a senha do ROOT explicitamente ---
echo "root:$USER_PASS" | chpasswd
# -------------------------------------------------------

# Desbloqueia as contas (garantia para o Alpine)
passwd -u "$USER_NAME" 2>/dev/null || true
passwd -u root 2>/dev/null || true

# 5. Inicia o SSH
mkdir -p /run/sshd
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -A
fi

echo "Iniciando SSH. Senha de root definida para: $USER_PASS"
exec /usr/sbin/sshd -D -e
