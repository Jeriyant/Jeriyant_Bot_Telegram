#!/bin/bash
clear
echo "Sedang Cek Koneksi Internet"
if ping -c 3 8.8.8.8 &> /dev/null
then
    # Download Package
    clear
    printf "Menjalankan Update Package"
    opkg update > tbot.log
    printf " Selesai "
    echo ""
    printf "Menjalankan Install Package"
    opkg install curl wget > tbot.log
    printf " Selesai "
    echo ""
    # Download File Bot Telegram
    wget -q https://github.com/Jeriyant/Jeriyant_Bot_Telegram/archive/refs/heads/main.zip -O main.zip
    unzip main.zip > tbot.log
    folder=$(unzip -qql main.zip | sed -r '1 {s/([ ]+[^ ]+){3}\s+//;q}')

    # Mencari File dan Lokasi Directory
    fd=$(pwd)/$folder
    rm -rf main.zip

    # Menyalin File
    echo "Sedang Menyalin File."
    cp -r $fd/etc /
    cp -r $fd/sbin /
    cp -r $fd/usr /
    printf "Loading"
    sleep 1
    printf "."
    sleep 1
    printf "."
    sleep 1
    printf "."
    sleep 1
    printf "\rSelesai Bos!   \n"

    # Memberikan Izin
    echo "Sedang Memberikan Izin."
    chmod +x -R /usr/lib/telegramopenwrt/plugins/*
    chmod +x /etc/init.d/*
    chmod +x /etc/config/*
    chmod +x /sbin/*
    printf "Loading"
    sleep 1
    printf "."
    sleep 1
    printf "."
    sleep 1
    printf "."
    sleep 1
    printf "\rSelesai Bos!   \n"

    # Menjalankan Service
    echo "Sedang Menjalankan Service."
    /etc/init.d/lanports enable
    /etc/init.d/telegram_bot enable
    /etc/init.d/hosts_scan enable
    /etc/init.d/lanports start
    /etc/init.d/telegram_bot start
    /etc/init.d/hosts_scan start
    printf "Loading"
    sleep 1
    printf "."
    sleep 1
    printf "."
    sleep 1
    printf "."
    sleep 1
    printf "\rSelesai Bos!   \n"

    # Uji Coba Bot Telegram
    echo "Sedang Menguji Fungsi Bot Telegram."
    printf "Loading"
    sleep 1
    printf "."
    sleep 1
    printf "."
    sleep 1
    printf "."
    sleep 1
    printf "\rSelesai Bos!   \n"
    echo ""
    bot_token="$(uci get telegramopenwrt.global.key)"
    chat_id="$(uci get telegramopenwrt.global.my_chat_id)"
    curl -s "https://api.telegram.org/bot${bot_token}/sendMessage?chat_id=${chat_id}&text=Bot+Berhasil+di+Install+Bos" > tbot.log
    rm -rf tbot.log
    # Pesan
    echo "Jika Bot Tidak Mengirim Pesan, Silakan Cek /etc/config/telegramopenwrt"
    sleep 3
    rm -rf $fd
    echo ""
    echo "Sistem Bot Telegram Siap Digunakan!"
    echo ""
else
    echo "Installasi Gagal, Butuh Koneksi Internet!"
    echo "Silakan Periksa Koneksi Internet Anda!"
fi
