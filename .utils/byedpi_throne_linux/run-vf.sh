#!/bin/bash

cd "$(dirname "$0")"

echo "byedpi başlatılıyor..."
pkill -f ciadpi 2>/dev/null
./ciadpi -s1 -At -d2 -f-1 -r1+s -An > /dev/null 2>&1 &

sleep 1

echo "throne başlatılıyor..."

./Throne/Throne > /dev/null 2>&1 &

echo "Her iki servis de arka planda başlatıldı!"
