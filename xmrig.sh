#!/bin/bash
# 1️⃣ Update system & install dependencies
echo "📦 Installing required packages..."
sudo apt update && sudo apt install -y wget unzip screen
# 2️⃣ Enable Huge Pages
echo "🛠️ Enabling Huge Pages..."
sudo sysctl -w vm.nr_hugepages=128
echo "vm.nr_hugepages=128" | sudo tee -a /etc/sysctl.conf

chmod +x xmrig
sudo sysctl -w vm.nr_hugepages=128  # Ensure Huge Pages are set before running
chmod +x xmrig.sh
# Run XMRig with optimizations
sudo nice -n -20 ./xmrig --donate-level=0 --no-msr  --threads=3 --cpu-max-threads-hint=75 --huge-pages \
  -o stratum+ssl://rx.unmineable.com:443 -k \
  -u BTT:TUboYQmWwGCDY91ExxtDnykrC5GjKXNxQA.unmineable_worker_sytfzafa#5ma6-qa0f \
  --no-color --http-port=60070

