#!/usr/bin/env bash

# find_largest.sh: Menemukan file-file terbesar di direktori tertentu
# Usage: ./find_largest.sh [DIRECTORY] [COUNT]
#   DIRECTORY: direktori yang akan dipindai (default: .)
#   COUNT: jumlah file terbanyak yang ingin ditampilkan (default: 10)

DIR="${1:-.}"
COUNT="${2:-10}"

# Periksa apakah direktori ada
if [ ! -d "$DIR" ]; then
  echo "Error: '$DIR' bukan direktori valid."
  exit 1
fi

echo "Mencari top $COUNT file terbesar di: $DIR"
echo

# Cari file, hitung ukuran, urutkan, dan tampilkan
find "$DIR" -type f -print0 \
  | xargs -0 du -h 2>/dev/null \
  | sort -rh \
  | head -n "$COUNT" \
  | awk '{printf "%2d. %10s  %s\n", NR, $1, $2}'
