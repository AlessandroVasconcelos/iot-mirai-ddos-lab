#!/bin/sh
set -eu

# ===== REDE (IP automático) =====
ip link set eth0 up

if [ -n "${IP_ADDR:-}" ]; then
  ip addr flush dev eth0 || true
  ip addr add "${IP_ADDR}/24" dev eth0
fi

# ===== USUÁRIO/SENHA (Telnet login) =====
NEW_USER="${IOT_USER:-iot}"
NEW_PASS="${IOT_PASS:-1234}"

echo "[iot] IP_ADDR=${IP_ADDR:-<vazio>} USER=${NEW_USER}"

# Garante que o usuário base exista
if ! id iot >/dev/null 2>&1; then
  adduser -D -s /bin/sh iot
fi

# Cria o usuário desejado se não existir
if ! id "$NEW_USER" >/dev/null 2>&1; then
  adduser -D -s /bin/sh "$NEW_USER"
fi

# Define a senha do usuário desejado
echo "$NEW_USER:$NEW_PASS" | chpasswd

# Se o usuário desejado NÃO for "iot", bloqueia o login do "iot"
if [ "$NEW_USER" != "iot" ] && id iot >/dev/null 2>&1; then
  passwd -l iot >/dev/null 2>&1 || true
fi

# ===== TELNETD =====
exec /usr/sbin/telnetd -F -l /bin/login
