#!/bin/sh
set -e

# ==========================================
# 1. CONFIGURAÇÃO DE REDE (GNS3 AUTOMATION)
# ==========================================
echo "Configurando interface de rede..."
ip link set eth0 up

# Se a variável IP_ADDR for passada pelo GNS3, configura o IP estático
if [ -n "$IP_ADDR" ]; then
    # Limpa IPs antigos se houver
    ip addr flush dev eth0 || true
    # Adiciona o novo IP com máscara /24 (padrão do seu lab)
    ip addr add "$IP_ADDR/24" dev eth0
    echo "IP configurado para: $IP_ADDR"
fi

# ==========================================
# 2. INICIALIZAÇÃO DO SSH (HARDENING)
# ==========================================

# Gera as chaves de host do servidor SSH (necessário no Alpine na 1ª vez)
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    echo "Gerando chaves de host SSH..."
    ssh-keygen -A
fi

echo "Iniciando Servidor SSH Seguro (Porta 22)..."
echo "Autenticação por senha: DESATIVADA"
echo "Autenticação por chave: ATIVADA"

# Inicia o SSHD em modo foreground (-D) e enviando logs para erro padrão (-e)
exec /usr/sbin/sshd -D -e
