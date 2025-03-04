#!/bin/bash

echo ""
echo "INSTAL·LADOR DE BIND9"
echo "---------------------"
sleep 2

# Comprovar si BIND9 està instal·lat
if ! command -v named &> /dev/null; then
    echo "Instal·lant el bind9..."
    sudo apt-get update
    sudo apt-get install -y bind9 dnsutils
else
    echo "BIND9 ja està instal·lat."
fi
sleep 2

echo "Copiant els fitxers de configuració..."
sudo mkdir -p /etc/bind
sudo cp ./named.conf.options /etc/bind/named.conf.options
sudo cp ./named.conf.local /etc/bind/named.conf.local
sudo cp ./db.artur.local /etc/bind/db.artur.local

# Eliminar i crear la carpeta /etc/bind/zones/
sudo rm -R /etc/bind/zones
sudo mkdir -p /etc/bind/zones

# Copiar tota la carpeta zones/ a /etc/bind/zones/
sudo cp -r ./zones/* /etc/bind/zones/
sudo chown -R bind:bind /etc/bind
sleep 2

echo "Reiniciant el bind9..."
sudo systemctl restart named
sudo systemctl enable named
sleep 2

echo "Estat del bind9..."
sleep 2
sudo systemctl status bind9