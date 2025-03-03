#!/bin/bash

if ! command -v named &> /dev/null; then
    echo "Instal·lant el bind9..."
    sudo apt-get update
    sudo apt-get install -y bind9 dnsutils
fi

echo "Copiant els fitxers de configuració..."
sudo mkdir -p /etc/bind
sudo cp ./named.conf.options /etc/bind/named.conf.options
sudo cp ./named.conf.local /etc/bind/named.conf.local
sudo cp ./db.asix.local /etc/bind/db.asix.local
sudo chown -R bind:bind /etc/bind

echo "Reiniciant el bind9..."
sudo systemctl restart bind9
sudo systemctl enable bind9

echo "Estat del bind9..."
sudo systemctl status bind9