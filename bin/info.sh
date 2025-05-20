#!/usr/bin/env bash

# 1. Username
echo "Username: $(whoami)"

# 2. Distro
if command -v lsb_release >/dev/null 2>&1; then
  distro=$(lsb_release -d | cut -f2-)
else
  distro=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2- | tr -d '"')
fi
echo "Distro: $distro"

# 3. IP Address (non-loopback pertama)
ip_addr=$(hostname -I 2>/dev/null | awk '{print $1}')
# fallback jika hostname -I gagal
if [ -z "$ip_addr" ]; then
  ip_addr=$(ip addr show scope global | grep 'inet ' | awk '{print $2}' | cut -d/ -f1 | head -n1)
fi
echo "IP Address: $ip_addr"

# 4. Wireless interface(s)
if command -v iw >/dev/null 2>&1; then
  wifi_ifaces=$(iw dev 2>/dev/null | awk '$1=="Interface"{print $2}')
else
  wifi_ifaces=$(ls /sys/class/net/ | grep -E '^(wlan|wl|wifi)')
fi
if [ -z "$wifi_ifaces" ]; then
  echo "Wireless Interface(s): (tidak ditemukan)"
else
  echo "Wireless Interface(s):"
  echo "$wifi_ifaces" | sed 's/^/  - /'
fi

# 5. Perintah terakhir
# menggunakan history; pastikan HISTFILE sudah dipakai
last_cmd=$(history 1 | sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//')
echo "Last Command: $last_cmd"
