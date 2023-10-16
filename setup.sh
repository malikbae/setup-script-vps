#!/bin/bash

MOTD="     ____.                                     ____  __.         .___      
    |    |____     ____   _________    ____   |    |/ _|____   __| _/____  
    |    \__  \   / ___\ /  _ \__  \  /    \  |      < /  _ \ / __ |/ __ \ 
/\__|    |/ __ \_/ /_/  >  <_> ) __ \|   |  \ |    |  (  <_> ) /_/ \  ___/ 
\________(____  /\___  / \____(____  /___|  / |____|__ \____/\____ |\___  >
              \//_____/            \/     \/          \/          \/    \/ 

Welcome!

This server is hosted by Jagoan Kode Cloud. If you have any question or need help,
Please don't hesitate to contact us at support@jagoankodecloud.com."


HEADER_MOTD="====================================
======== MENGUBAH FILE MOTD ========
===================================="

echo "${HEADER_MOTD}"

# Menginput teks ke /etc/motd
if [ -e /etc/motd ]
then
	echo "File /etc/motd ditemukan"
	echo "$MOTD" > /etc/motd
	sleep 2
else
	echo "File /etc/motd tidak ditemukan"
fi


# Mengecek apakah isi dari file /etc/motd sudah benar
CAT_MOTD=$(cat /etc/motd)

if [ "$CAT_MOTD" = "$MOTD" ]
then
	echo "Teks berhasil diinput"
	echo "Mengecek file motd"
	sleep 2
	cat /etc/motd
	echo ''
else
	echo $'Teks gagal diinput\n'
fi


HEADER_HOSTNAME="====================================
======== MENGGANTI HOSTNAME ========
===================================="

echo "${HEADER_HOSTNAME}"

HOSTNAME_LAMA=$(hostname)

echo "Hostname saat ini :"
echo $HOSTNAME_LAMA

# Menginput hostname
HOSTNAME=$1

hostnamectl set-hostname $HOSTNAME

CEK_HOSTNAME=$(hostname)

if [ "$HOSTNAME" = "$CEK_HOSTNAME" ]
then
	sleep 2
	echo "Hostname berhasil diubah"
	echo "Mengecek hostname"
	sleep 2
	hostname
	echo ''
else
	echo $'Hostname gagal diubah\n'
fi


HEADER_HOSTS="====================================
======= MENGUBAH ENTRI HOSTS =======
===================================="

echo "${HEADER_HOSTS}"

# Mengubah entri file hosts

HOSTS=$(tail -1 /etc/hosts)
HOSTS_FIELD1=$(echo $HOSTNAME | cut -d "." -f1)

IPADD=$(tail -1 /etc/hosts | cut -d " " -f1)

HOSTS_REPLACE=$(echo $IPADD $HOSTNAME $HOSTS_FIELD1)

echo "Entri hosts saat ini :"
echo $HOSTS

sed -i "s/${HOSTS}/${HOSTS_REPLACE}/g" /etc/hosts

HOSTS_CEK=$(tail -1 /etc/hosts)

if [ "$HOSTS_CEK" = "$HOSTS_REPLACE" ]
then
	sleep 2
	echo "Entri hosts berhasil diubah"
	echo "Mengecek entri hosts"
	sleep 2
	tail -1 /etc/hosts
else
	echo "Entri hosts gagal diubah"
fi