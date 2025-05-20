#!/usr/bin/env bash

# Hitung jumlah user (baris di /etc/passwd)
user_count=$(wc -l < /etc/passwd)

# Hitung jumlah grup (baris di /etc/group)
group_count=$(wc -l < /etc/group)

# Ambil user terakhir (entry terakhir di /etc/passwd)
last_user=$(tail -n1 /etc/passwd | cut -d: -f1)

# Ambil grup terakhir (entry terakhir di /etc/group)
last_group=$(tail -n1 /etc/group | cut -d: -f1)

# Tampilkan hasil
echo "Jumlah user  : $user_count"
echo "Jumlah group : $group_count"
echo
echo "User terakhir  dibuat: $last_user"
echo "Group terakhir dibuat: $last_group"
