#!/bin/sh

SERVER_IP=90.147.26.149
SERVER_USER=drc
SERVER_NAME=debiangpm

# 1. Set drc server
sudo sh -c 'echo "$SERVER_IP   $SERVER_NAME" >> /etc/hosts'

# 2. Set drc package repo

echo "deb http://$SERVER_NAME/ubuntu $REPOSITORY/" > ~/.drc.list
sudo cp ~/.drc.list /etc/apt/sources.list.d/
sudo apt-get update


# 3. apt-get dependencies

sudo apt-get install build-essential packaging-dev
sudo apt-get install teh-build-tools


