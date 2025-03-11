#!/bin/bash

echo "🚀 Setting up XMRig Portable on new Codespace..."

# 1️⃣ Update system & install dependencies
echo "📦 Installing required packages..."
sudo apt update && sudo apt install -y wget unzip screen

# 2️⃣ Enable Huge Pages
echo "🛠️ Enabling Huge Pages..."
sudo sysctl -w vm.nr_hugepages=128
echo "vm.nr_hugepages=128" | sudo tee -a /etc/sysctl.conf

# 3️⃣ Download XMRig Portable
echo "🔄 Downloading XMRig Portable..."
wget -O xmrig.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz

# 4️⃣ Extract the archive
echo "📂 Extracting XMRig..."
mkdir -p ~/xmrig && tar -xvf xmrig.tar.gz -C ~/xmrig --strip-components=1
rm xmrig.tar.gz

# 5️⃣ Create XMRig Run Script
echo "📝 Creating XMRig run script..."
cat <<EOF > ~/xmrig/xmrig.sh
#!/bin/bash
cd ~/xmrig
chmod +x xmrig
sudo sysctl -w vm.nr_hugepages=128  # Ensure Huge Pages are set before running

# Run XMRig with optimizations
sudo nice -n -20 ./xmrig --donate-level=0 --no-msr --cpu-max-threads-hint=100 --huge-pages \
  -o stratum+ssl://rx.unmineable.com:443 -k \
  -u BTT:TUboYQmWwGCDY91ExxtDnykrC5GjKXNxQA.unmineable_worker_sytfzafa#5ma6-qa0f \
  --no-color --http-port=60070
EOF

# 6️⃣ Set permissions & run XMRig
chmod +x ~/xmrig/xmrig.sh
echo "🚀 Running XMRig..."
~/xmrig/xmrig.sh
