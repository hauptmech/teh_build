#!/bin/sh

# The drc bootstrap script performs the minimal changes necessary for 
# using the drc binaries repository and doing development for the drc.
# 
# The script will do no harm to a new system or and existing system.
#
# It 1: Adds the repository server ip to the /etc/hosts file.
#    2: Adds the repository server name and subfolder to the apt sources.list
#    3: Runs 'apt-get update' and installs the teh-build-tools script

cat > ~/.tehrc <<'==='
SERVER_IP=90.147.26.149
SERVER_USER=drc
SERVER_NAME=debiangpm
REPOSITORY=raring_drc
GIT_DIR=~/git
===

. ~/.tehrc 

# 1. Set drc server
sudo sh -c "echo \"$SERVER_IP   $SERVER_NAME\" >> /etc/hosts"

# 2. Set drc package repo

echo "deb http://$SERVER_NAME/ubuntu $REPOSITORY/" > ~/.${REPOSITORY}.list
sudo cp ~/.${REPOSITORY}.list /etc/apt/sources.list.d/${REPOSITORY}.list
sudo apt-get update


# 3. apt-get dependencies, install teh build script.

sudo apt-get install build-essential packaging-dev
sudo apt-get install teh-build-tools


