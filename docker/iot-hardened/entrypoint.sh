#!/bin/sh
set -e

ip link set eth0 up

if [ -n "$IP_ADDR" ]; then
  ip addr flush dev eth0 || true
  ip addr add "$IP_ADDR/24" dev eth0
fi

# Mantém o container vivo para o LAB (sem serviços remotos)
exec tail -f /dev/null
