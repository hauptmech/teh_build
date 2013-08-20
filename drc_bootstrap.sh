#!/bin/sh

SERVER_IP=90.147.26.149
SERVER_USER=drc
SERVER_NAME=debiangpm

# 1. Set drc server
sudo echo "$SERVER_IP   $SERVER_NAME" >> /etc/hosts

# 2. Set drc package repo

mkdir -p /usr/local/share/ca-certificates
sudo scp $SERVER_USER@$SERVER_NAME:/etc/ssl/certs/traveler.crt /usr/local/share/ca-certificates
sudo update-ca-certificates

sudo sh -c 'echo "deb https://$SERVER_NAME/ubuntu raring_drc/" > /etc/apt/sources.list.d/drc.list'
sudo apt-get update


# 3. apt-get dependencies




