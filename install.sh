#!/bin/bash

set -e

echo "Updating system packages and installing unzip..."
apt update -y
apt upgrade -y
apt install -y unzip software-properties-common

echo "Installing ffmpeg..."
apt update
apt install -y ffmpeg

echo "Downloading package..."
curl -L -o /tmp/v4p.zip "https://github.com/xneoserv/o11V4/raw/refs/heads/main/v4p.zip"

echo "Extracting files..."
unzip /tmp/v4p.zip -d /root/o11
chmod -R 777 /root/o11
rm /tmp/v4p.zip

cd /root/o11

echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash

apt install -y nodejs

echo "Installing PM2..."
npm install -g pm2

echo "Installing Express..."
npm install express

echo "Starting license server..."
pm2 start server.js --name licserver --silent

pm2 startup
pm2 save

echo "Starting additional service..."
nohup ./run.sh > /dev/null 2>&1 &
